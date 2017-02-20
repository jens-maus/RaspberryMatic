/* HM-LGW emulation for HM-MOD-RPI
 *
 * Copyright (c) 2015 Oliver Kastl
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 * IN THE SOFTWARE.
 */


#include <termios.h>
#include <unistd.h>
#include <libgen.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/eventfd.h>
//#include <sys/time.h>
#include <sys/types.h>
#include <sys/poll.h>
#include <signal.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h> 
//#include <time.h>
// #include <memory.h>
//#include <ctype.h>
#include <pthread.h>
#include <errno.h>
#include <string.h>
#include <stdint.h>
#include <arpa/inet.h>
#include "hmframe.h"

static int g_serverBidcosFd = -1;
static int g_serverKeepAliveFd = -1;
static int g_serialFd = -1;
static int g_termEventFd = -1;
static int g_resetFileFd = -1;
static bool g_debug = false;
static bool g_inBootloader = false;

//const char *g_productString = "01,eQ3-HM-LGW,1.1.4,ABC0123456";

#define VERSION "0.0.2"
static char *g_address=NULL;
static const char *g_productString = "01,Revilo-HM-LGW," VERSION ",%s\r\n";

static char* create_hex_string( const char* source, int length, char* target, int size )
	{
	char* current;
	unsigned char value;

	if ( length > size / 2 - 1 ) length = size / 2 - 1;

    if ( source )
        {
		current = target;
		while ( length-- )
			{
			value = *source++;
			sprintf( current, " %02x", value ); 
			current += 3;
			}
		}

	return target;
	}
    
static unsigned char convert_ascii( unsigned char c )
{
	if( c < 0x20 || c > 0x7e )
		return 0x2e;
	else
		return c;
}

static char* create_asc_string( const char* source, int length, char* target, int size )
	{
	unsigned char* current;
	unsigned char value;

	if ( length > size - 1 ) length = size - 1;

	if ( source )
		{
		current = (unsigned char*)target;
		while ( length-- )
			{
			value = *source++;
			*current++ = convert_ascii( value );
			}
		*current = 0;
		}

	return target;
	}

static void dump_data( const char* data, int length )
	{
	char hex[ 100 ];
	char asc[ 100 ];

			{

			if ( data )
				{
				int offset;

				offset = 0;
				while ( length > 0 )
					{
					int chunk;
					int len;
					char LineBuf[100];


					length -= 16;
					chunk = length >= 0 ? 16 : 16 + length;

					len = sprintf( LineBuf, "%04x:%s  %s\n", offset, create_hex_string( data, chunk, hex, sizeof hex ), create_asc_string( data, chunk, asc, sizeof asc ) );
					write( 2, LineBuf, len ); // stderr

					offset += chunk;
					data += chunk;
					}
				}
			}
	}

static void error(const char *msg)
{
    perror(msg);
    exit(EXIT_FAILURE);
}

static void sigterm_handler_server(int sig)
{
    if( g_debug )
    {
        fprintf( stderr, "sigterm_handler_server SIG %d\n", sig);
        fflush( stderr );
    }
  
	//exit(EXIT_SUCCESS);
}

static void sigSetHandlerServer(int signum)
{
   struct sigaction newaction;
   memset(&newaction, 0, sizeof(newaction));
   newaction.sa_handler = sigterm_handler_server;
   sigaction(signum, &newaction, NULL);
}

static int resetCoPro( void )
{
    if( g_resetFileFd != -1 )
    {
        write( g_resetFileFd, "0", 1 ); // Hold reset
        usleep( 10000 ); // 10 ms should be ok
        write( g_resetFileFd, "1", 1 ); // Release reset
    }
    return g_resetFileFd;
}

static int openResetFile( int port )
{
    int fd;
    char fileName[80];
    sprintf( fileName, "/sys/class/gpio/gpio%d/value", port );
    if( access( fileName, F_OK ) == -1 )
    {
        sprintf( fileName, "/sys/class/gpio/export" );
        fd = open( fileName, O_WRONLY );
        if( fd == -1 )
        {
            perror("open /sys/class/gpio/export");
        }
        else
        {
            sprintf( fileName, "%d", port );
            if( write( fd, fileName, strlen( fileName ) ) < 1 ) 
            {
                perror("write /sys/class/gpio/export");
            }
            close( fd );
        }
    }
    sprintf( fileName, "/sys/class/gpio/gpio%d/direction", port );
    fd = open( fileName, O_WRONLY );
    if( fd == -1 )
    {
        perror("open direction");
    }
    else
    {
        if( write( fd, "out", 3 ) < 3 ) 
        {
            perror("write direction");
        }
        close( fd );
    }
    sprintf( fileName, "/sys/class/gpio/gpio%d/value", port );
    fd = open( fileName, O_RDWR );
    if( fd == -1 )
    {
        perror("open value");
    }
    return fd;
}

static int readUntilEOL( int fd, char *buffer, int bufsize )
{
    int result=0;
    char *buf = buffer;
    while( bufsize )
    {
        int r = read( fd, buf, 1 );
        if( r <= 0 )
        {
            result = r;
            break;
        }
        if( *buf == '\r' )
        {
            continue;
        }
        result += r;
        bufsize -= r;
        if( *buf == '\n' )
        {
            *buf = 0;
            break;
        }
        buf+=r;
    }
    return result;
}


static void shutdownAndCloseSocket( int *fd )
{
    if( *fd != -1 )
    {
        shutdown( *fd, SHUT_RDWR);
        close( *fd );
        *fd = -1;
    }
}

static void * keepAliveThreadFunc(void *x)
{
    if( g_debug )
        fprintf( stderr,  "keepAliveThread started!\n" );
    struct pollfd pfds[3];
    int sockFd = -1;
    char buffer[256];
    unsigned char keepaliveCount = 0;
    unsigned char messageCounter = 0;
    
    while( 1 )
    {
        pfds[0].fd = g_termEventFd;
        pfds[0].events = POLLIN;
        pfds[1].fd = sockFd;
        pfds[1].events = POLLIN;
        pfds[2].fd = g_serverKeepAliveFd;
        pfds[2].events = POLLIN;
        
        int pollResult = poll(pfds, 3, sockFd >= 0 ? 20000 : -1);
        
        if( pollResult < 0 )
        {
            break;
        }
        
        if( pollResult == 0 )
        {
            if( g_debug )
                fprintf( stderr,  "keepalive thread timeout\n" );
            shutdownAndCloseSocket( &sockFd );
            continue;
        }
        
        if ((pfds[0].revents & POLLIN)) // terminate event
        {
            break;
        }
        
        if ((pfds[1].revents & POLLIN)) // client socket event
        {
            int r = readUntilEOL( sockFd, buffer, sizeof(buffer) );
            if( r <= 0 )
            {
                shutdownAndCloseSocket( &sockFd );
                fprintf( stderr,  "Keepalive client closed connection.\n" );
            }
            else
            {
                if( g_debug )
                    fprintf( stderr,  "received %d bytes: %s\n", r, buffer );
                char letter = buffer[0];
                if( letter == 'L' || letter == 'K' )
                {
                    int counter;
                    if( 1 == sscanf( &buffer[1], "%x", &counter ) )
                    {
                        if( letter == 'L' )
                        {
                            keepaliveCount = counter;
                        }
                        else
                        {
                            keepaliveCount++;
                            if( counter != keepaliveCount )
                            {
                                shutdownAndCloseSocket( &sockFd );
                                continue;
                            }
                        }
                        sprintf( buffer, ">%c%2.2x\r\n", letter, counter );
                        // fprintf( stderr,  "sending: %s\n", buffer );
                        writeall( sockFd, buffer, strlen( buffer ) );
                    }
                }
            }
        }
        
        
        if (pfds[2].revents & POLLIN) // client connect
        {
            struct sockaddr_in csin;
            socklen_t csinlen;
            in_addr_t client_addr;

            memset(&csin, 0, sizeof(csin));
            csinlen = sizeof(csin);
            int sock = accept(g_serverKeepAliveFd, (struct sockaddr*)&csin, &csinlen);
            if (sock == -1)
            {
                perror("Couldn't accept client");
                fflush( stderr );
            }
            else
            {
                client_addr = ntohl(csin.sin_addr.s_addr);
                fprintf( stderr, "Client %d.%d.%d.%d connected to keepalive port!\n",
                    (client_addr & 0xff000000) >> 24,
                    (client_addr & 0x00ff0000) >> 16,
                    (client_addr & 0x0000ff00) >> 8,
                    (client_addr & 0x000000ff));
                fflush( stdout );
                if( sockFd == -1 )
                {
                    sockFd = sock;
                    sprintf( buffer, "H%2.2x,", ++messageCounter );
                    sprintf( &buffer[strlen(buffer)], g_productString, g_address );
                    writeall( sockFd, buffer, strlen( buffer ) );
                    sprintf( buffer, "S%2.2x,SysCom-1.0\r\n", ++messageCounter );
                    writeall( sockFd, buffer, strlen( buffer ) );
                }
                else
                {
                    shutdownAndCloseSocket( &sock );
                }
            }
        }
    }

    shutdownAndCloseSocket( &sockFd );
    
    if( g_debug )
        fprintf( stderr,  "keepAliveThread stopped!\n" );
    return 0;
}

static void * bidcosThreadFunc(void *x)
{
    if( g_debug )
        fprintf( stderr,  "bidcosThread started!\n" );
    struct pollfd pfds[4];
    int sockFd = -1;
    bool synched = false;
    char buffer[4096];
    unsigned char messageCounter = 0;
    
    
    while( 1 )
    {
        pfds[0].fd = g_serialFd;
        pfds[0].events = POLLIN;
        pfds[1].fd = g_termEventFd;
        pfds[1].events = POLLIN;
        pfds[2].fd = sockFd;
        // pfds[2].events = POLLIN|POLLHUP;
        pfds[2].events = POLLIN;
        pfds[3].fd = g_serverBidcosFd;
        pfds[3].events = POLLIN;
        
        int pollResult = poll(pfds, 4, -1);
        
        if( pollResult < 0 )
        {
            break;
        }
        
        if( pollResult == 0 )
        {
            if( g_debug )
                fprintf( stderr,  "bidcos thread timeout\n" );
            continue;
        }
        
        if (pfds[3].revents & POLLIN) // client connect
        {
            struct sockaddr_in csin;
            socklen_t csinlen;
            in_addr_t client_addr;

            memset(&csin, 0, sizeof(csin));
            csinlen = sizeof(csin);
            int sock = accept(g_serverBidcosFd, (struct sockaddr*)&csin, &csinlen);
            if (sock == -1)
            {
                perror("Couldn't accept client");
                fflush( stderr );
            }
            else
            {
                client_addr = ntohl(csin.sin_addr.s_addr);
                fprintf( stderr, "Client %d.%d.%d.%d connected to BidCos port!\n",
                    (client_addr & 0xff000000) >> 24,
                    (client_addr & 0x00ff0000) >> 16,
                    (client_addr & 0x0000ff00) >> 8,
                    (client_addr & 0x000000ff));
                fflush( stdout );
                if( sockFd == -1 )
                {
                    sockFd = sock;
                    sprintf( buffer, "H%2.2x,", ++messageCounter );
                    sprintf( &buffer[strlen(buffer)], g_productString, g_address );
                    writeall( sockFd, buffer, strlen( buffer ) );
                    sprintf( buffer, "S%2.2x,BidCoS-over-LAN-1.0\r\n", ++messageCounter );
                    writeall( sockFd, buffer, strlen( buffer ) );
                }
                else
                {
                    shutdownAndCloseSocket( &sock );
                }
            }
        }
        
        if (pfds[0].revents & POLLIN) // serial port
        {
            int result = readBidcosFrame( g_serialFd, buffer, sizeof( buffer ) );
            // int result = read( g_serialFd, buffer, sizeof( buffer ) );
            if( result > 0 )
            {
                if( g_debug )
                {
                    fprintf( stderr,  "Received %d bytes from serial\n", result );
                    dump_data( buffer, result );
                }
                if( sockFd >= 0 && synched )
                {
                    writeall( sockFd, buffer, result );
                }
            }
        }
        
        if (pfds[2].revents & POLLIN) // Ethernet client
        {
            int result;

            if( synched )
            {
                // result = readBidcosFrame( sockFd, buffer, sizeof( buffer ) );
                result = read( sockFd, buffer, sizeof( buffer ) );
            }
            else
            {
                result = readUntilEOL( sockFd, buffer, sizeof(buffer) );
            }
            
            if( result <= 0 )
            {
                close( sockFd );
                sockFd = -1;
                tcflush(g_serialFd, TCIOFLUSH);
                fprintf( stderr,  "BidCos client closed connection.\n" );
                if( resetCoPro() == -1 && !g_inBootloader )
                {
                    if( sendEnterBootloader( g_serialFd ) > 0 )
                        g_inBootloader = true;
                }
                synched = false;
            }
            else
            {
                if( g_debug )
                {
                    fprintf( stderr,  "Received %d bytes from sockFd\n", result );
                }
                if( synched )
                {
                    if( g_debug )
                    {
                        dump_data( buffer, result );
                    }
                    writeall( g_serialFd, buffer, result );
                }
                else
                {
                    int index, number;
                    if( g_debug )
                    {
                        fprintf( stderr,  "sync data: %s\n", buffer );
                    }
                    if( sscanf( buffer, ">%x,%d", &index, &number ) == 2 )
                    {
                        if( index == (int)messageCounter && number == 0 )
                        {
                            synched = true;
                            /* Flush anything already in the serial buffer */
                            tcflush(g_serialFd, TCIFLUSH);
                            g_inBootloader = false;
                        }
                    }
                }
            }
        }
        if ((pfds[1].revents & POLLIN))
        {
            break;
        }
    }
    
    shutdownAndCloseSocket( &sockFd );
    
    if( resetCoPro() == -1 && !g_inBootloader )
    {
        if( sendEnterBootloader( g_serialFd ) > 0 )
            g_inBootloader = true;
        tcdrain( g_serialFd );
    }
    

    if( g_debug )
        fprintf( stderr,  "bidcosThread stopped!\n" );
    return 0;
}

int openMasterSocket( const char *iface, int port )
{
	struct sockaddr_in sin;
	int sock;
	int n;
    
	sock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
	if (sock == -1) {
		error("Can't open socket");
	}

	n = 1;
	if (setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &n, sizeof(n)) == -1) {
		error("Can't set socket options");
	}

	memset(&sin, 0, sizeof(sin));
	sin.sin_family = AF_INET;
	sin.sin_port = htons(port);
	if (!iface) {
		sin.sin_addr.s_addr = htonl(INADDR_ANY);
	} else {
		if (inet_pton(AF_INET, iface, &(sin.sin_addr.s_addr)) != 1) {
			fprintf(stderr, "Can't convert IP %s, aborting!\n", iface);
			exit( EXIT_FAILURE );
		}
	}

	if (bind(sock, (struct sockaddr*)&sin, sizeof(sin)) == -1) {
		error("Can't bind socket");
	}

	if (listen(sock, 1) == -1) {
		error("Can't listen on socket");
	}
    
     int flags = fcntl(sock, F_GETFL, 0);
     if( flags == -1 )
     {
		error("Can't get socket flags");
     }
    
     if( fcntl( sock, F_SETFL, flags| O_NONBLOCK ) == -1 )
     {
		error("Can't set socket to nonblocking mode");
     }
    return sock;
}

int openSerial( const char *portname )
{
    int fd;
 
    /* Open the file descriptor in non-blocking mode */
    fd = open(portname, O_RDWR | O_NOCTTY );
    if( fd < 0 )
    {
        return -1;
    }
 
    /* Set up the control structure */
     struct termios toptions;
     
     /* Get currently set options for the tty */
     if( tcgetattr(fd, &toptions) < 0 )
     {
        close( fd );
        return -1;
     }
     
    /* Set custom options */
     
    /* 115200 baud */
     cfsetispeed(&toptions, B115200);
     cfsetospeed(&toptions, B115200);
     #if 1
     /* 8 bits, no parity, no stop bits */
     toptions.c_cflag &= ~PARENB;
     toptions.c_cflag &= ~CSTOPB;
     toptions.c_cflag &= ~CSIZE;
     toptions.c_cflag |= CS8;
     /* no hardware flow control */
     toptions.c_cflag &= ~CRTSCTS;
     /* enable receiver, ignore status lines */
     toptions.c_cflag |= CREAD | CLOCAL;
     /* disable input/output flow control, disable restart chars */
     toptions.c_iflag &= ~(IXON | IXOFF | IXANY);
     /* disable canonical input, disable echo,
     disable visually erase chars,
     disable terminal-generated signals */
     toptions.c_iflag &= ~(ICANON | ECHO | ECHOE | ISIG);
     /* disable output processing */
     toptions.c_oflag &= ~OPOST;
     #endif
     
     cfmakeraw( &toptions );
     
     /* wait for 1 characters to come in before read returns */
     toptions.c_cc[VMIN] = 1;
     /* 1/10 sec time to wait before read returns */
     toptions.c_cc[VTIME] = 1;
     
    /* commit the options */
     if( tcsetattr(fd, TCSANOW, &toptions) < 0)
     {
        close( fd );
        return -1;
     }
     
     /* Flush anything already in the serial buffer */
     tcflush(fd, TCIFLUSH);

     return fd;
}

void hmlangw_syntax(char *prog)
{
	fprintf(stderr, "Syntax: %s -n serialnumber options\n\n", prog);
	fprintf(stderr, "Possible options:\n");
	fprintf(stderr, "\t-n n\tSpecify 10-digit serial number\n");
	fprintf(stderr, "\t\tSaves it to serialnumber.txt for later use\n");
	fprintf(stderr, "\t-n show\tShow 10-digit serial number of HM-MOD-RPI\n");
	fprintf(stderr, "\t-n auto\tUses 10-digit serial number of HM-MOD-RPI\n");
	fprintf(stderr, "\t\tReads serial number to serialnumber.txt, if possible\n");
	fprintf(stderr, "\t\tSaves serial number to serialnumber.txt, if possible\n");
	fprintf(stderr, "\t-n read\tUses 10-digit serial number from serialnumber.txt\n");
	fprintf(stderr, "\t-n save\tSaves 10-digit serial number to serialnumber.txt\n");
	fprintf(stderr, "\t-s\tname of serial device to use. Default is /dev/ttyAMA0\n");
	fprintf(stderr, "\t-r\tHM-MOD-RPI reset GPIO pin (default 18, -1 to disable)\n");
	fprintf(stderr, "\t-D\tdebug mode\n");
	fprintf(stderr, "\t-x\texecute HM-MOD-RPI reset and exit\n");
	fprintf(stderr, "\t-h\tthis help\n");
	fprintf(stderr, "\t-l ip\tlisten on given IP address only (for example 127.0.0.1)\n");
	fprintf(stderr, "\t-u\tupdate firmware of HM-MOD-RPI\n");
	fprintf(stderr, "\t-f\tforce update firmware of HM-MOD-RPI\n");
	fprintf(stderr, "\t-V\tshow version (" VERSION ")\n");

}

static bool getPath( char *path, int dest_len )
{
    int len = readlink ("/proc/self/exe", path, dest_len-1);
    if ( len != -1)
    {
        path[len]=0;
        dirname (path);
        strcat  (path, "/");
        return true;
    }
    return false;
}

static char *getSerialNumberFromFile( void )
{
    static char SerialNumber[11];
    char buffer[256];
    bool result = false;
    if( getPath( buffer, sizeof( buffer ) - 20 ) )
    {
        strcat( buffer, "serialnumber.txt" );
        FILE *file = fopen( buffer, "r" );
        if( file )
        {
            if( fgets( SerialNumber, sizeof( SerialNumber ), file ) )
            {
                result = true;
            printf( "Read serial number %s from %s\n", SerialNumber, buffer );
            }
            fclose( file );
        }
    }
    if( !result )
        return 0;
    return SerialNumber;
}

static bool putSerialNumberToFile( char *serialNumber )
{
    char buffer[256];
    bool result = false;
    if( getPath( buffer, sizeof( buffer ) - 20 ) )
    {
        strcat( buffer, "serialnumber.txt" );
        FILE *file = fopen( buffer, "w" );
        if( file )
        {
            fprintf( file, "%s\n", serialNumber );
            result = true;
            printf( "Written serial number %s to %s\n", serialNumber, buffer );
            fclose( file );
        }
    }
    return result;
}

int main(int argc, char **argv)
{
    const char *serialName = "/dev/ttyAMA0";
    int bidcosPort = 2000;
    int keepalivePort = 2001;
    int resetPort = 18;
    pthread_t bidcosThread = 0;
    pthread_t keepaliveThread = 0;
	int opt;
	char *iface = 0;
    bool executeReset = false;
    bool showSerial = false;
    bool autoSerial = false;
    bool saveSerial = false;
    bool updateFirmware = false;
    bool forceUpdateFirmware = false;
    bool startThreads = true;
    
	while((opt = getopt(argc, argv, "DVs:r:l:n:xuf")) != -1)
    {
		switch (opt)
        {
			case 'D':
				g_debug = true;
				break;
            case 's':
                serialName = optarg;
                break;
            case 'r':
                resetPort = atoi( optarg );
                break;
			case 'l':
				iface = optarg;
				break;
			case 'x':
                executeReset = true;
                startThreads = false;
				break;
			case 'f':
                forceUpdateFirmware = true;
                // fall thru
			case 'u':
                updateFirmware = true;
                startThreads = false;
                break;
			case 'n':
                if( 0 == strcmp( optarg, "read" ) )
                {
                    g_address = getSerialNumberFromFile();
                    if( !g_address )
                    {
                        printf( "Can't read serial number from file serialnumber.txt\n" );
                    }
                    break;
                }
                if( 0 == strcmp( optarg, "show" ) )
                {
                    showSerial = true;
                    startThreads = false;
                    break;
                }
                if( 0 == strcmp( optarg, "auto" ) )
                {
                    // showSerial = true;
                    autoSerial = true;
                    g_address = getSerialNumberFromFile();
                    break;
                }
                if( 0 == strcmp( optarg, "save" ) )
                {
                    showSerial = true;
                    saveSerial = true;
                    startThreads = false;
                    break;
                }
                if( strlen( optarg ) != 10 )
                {
					fprintf(stderr, "Serial number must be 10 digits!\n");
					exit(EXIT_FAILURE);
                }
                g_address = optarg;
                putSerialNumberToFile( g_address );
                break;
			case 'V':
				printf("hmlangw " VERSION "\n");
				printf("Copyright (c) 2015 Oliver Kastl\n\n");
				exit(EXIT_SUCCESS);
			case 'h':
			case ':':
			case '?':
			default:
				hmlangw_syntax(argv[0]);
				exit(EXIT_FAILURE);
				break;
		}
	}
    
    if( autoSerial && !g_address )
    {
        showSerial = true;
        saveSerial = true;
    }
    
    if( !g_address && !executeReset && !updateFirmware && !showSerial )
    {
        fprintf( stderr,  "Serial number is missing. Use -n option.\n" );
        exit(EXIT_FAILURE);
    }
    
    if( updateFirmware && showSerial )
    {
        fprintf( stderr,  "Can't update firmware and get serial number.\n" );
        exit(EXIT_FAILURE);
    }
    
    
    g_serialFd = openSerial( serialName );
    
    if( g_serialFd < 0 )
    {
        fprintf( stderr,  "Can't open serial port %s!\n", serialName );
        exit(EXIT_FAILURE);
    }
 
    if( g_debug )
        fprintf( stderr,  "serial fd %d name %s\n", g_serialFd, serialName );
        
    if( strcmp( serialName, "/dev/ttyAMA0" ) )
    {
        resetPort = -1;
    }
    
    if( resetPort >= 0 )
    {
        g_resetFileFd = openResetFile( resetPort );
    
        if( g_resetFileFd < 0 )
        {
            fprintf( stderr,  "Can't open reset file!\n" );
            exit(EXIT_FAILURE);
        }
    }
    
    if( resetCoPro() == -1 )
    {
        if( sendEnterBootloader( g_serialFd ) > 0 )
            g_inBootloader = true;
    }
    
    if( g_debug )
        fprintf( stderr,  "reset fd %d gpio port %d\n", g_resetFileFd, resetPort );
        
    if( showSerial || updateFirmware )
    {
        char cmdBuf[256];
        char path[256];
        //char tmp[256];
        const char *cmd = "-u";
        //strcpy( tmp, "hmlgwXXXXXX" );
        
        char *tmp = tempnam( 0, "hmlgw" );
        
        if( tmp == 0 )
        {
            error( "tmp file" );
        }
        
        // printf( "%s\n", tmp );
        
        if( showSerial )
        {
            cmd = "-se";
        }
        else if( forceUpdateFirmware )
        {
            cmd = "-u -f";
        }
        
        if( getPath( path, sizeof( path ) ) )
        {
            FILE *file;
            strcat( path, "eq3" );
            // printf( "Path %s\n", path );
            sprintf( cmdBuf, "/lib/ld-linux.so.3 --library-path %s/lib %s/bin/eq3configcmd update-coprocessor -p %s %s -c -l 2 -d %s/firmware -t HM-MOD-UART 2> %s",
                path, path, serialName, cmd, path, tmp );
            system( cmdBuf );
            file = fopen( tmp, "r" );
            if( 0 != file )
            {
                while( fgets( cmdBuf, sizeof( cmdBuf ), file ) )
                {
                    printf( "%s", cmdBuf );
                }
                {
                    rewind( file );
                    while( fgets( cmdBuf, sizeof( cmdBuf ), file ) )
                    {
                        char *dummy[3];
                        char *keyword;
                        char *serial;
                        if( 5 == sscanf( cmdBuf, "%ms %ms %ms %ms %ms", &dummy[0], &dummy[1], &dummy[2], &keyword, &serial ) )
                        {
                            if( strcmp( keyword, "SerialNumber:" ) == 0 )
                            {
                                // printf( "%s\n", serial );
                                g_address = serial;
                            }
                            for( int i=0; i<3; i++ )
                            {
                                free( dummy[i] );
                            }
                            free( keyword );
                            if( g_address )
                            {
                                if( saveSerial )
                                {
                                    putSerialNumberToFile( g_address );
                                }
                                break;
                            }
                            free( serial );
                        }
                    }
                    if( g_address == 0 )
                    {
                        printf( "can't get serial number!\n" );
                        startThreads = false;
                    }
                }
                fclose( file );
            }
        }
        remove( tmp );
    }
    
    
    if( startThreads )
    {
        if( autoSerial )
        {
            if( resetCoPro() == -1 )
            {
                if( sendEnterBootloader( g_serialFd ) > 0 )
                    g_inBootloader = true;
            }
        }
        g_termEventFd = eventfd(0, 0);
        
        g_serverBidcosFd = openMasterSocket( iface, bidcosPort );
        g_serverKeepAliveFd = openMasterSocket( iface, keepalivePort );
        
        sigSetHandlerServer(SIGTERM);
        sigSetHandlerServer(SIGINT);
        
        pthread_attr_t pthAttr;
        struct sched_param sched ;
        memset (&sched, 0, sizeof(sched)) ;
        sched.sched_priority = 20;
        
        pthread_attr_init(&pthAttr);
        pthread_attr_setschedpolicy(&pthAttr, SCHED_RR);
        pthread_attr_setinheritsched(&pthAttr, PTHREAD_EXPLICIT_SCHED);
        pthread_attr_setschedparam(&pthAttr, &sched );
    
        if( pthread_create( &bidcosThread, &pthAttr, bidcosThreadFunc, 0 ) )
        {
            exit(EXIT_FAILURE);
        }
        
        if( pthread_create( &keepaliveThread, &pthAttr, keepAliveThreadFunc, 0 ) )
        {
            exit(EXIT_FAILURE);
        }
    
        sigset_t mask;
        sigfillset(&mask);
        sigdelset(&mask, SIGTERM);
        sigdelset(&mask, SIGINT);
        sigsuspend( &mask );
    
        uint64_t u=1;
        write(g_termEventFd, &u, sizeof(uint64_t));
        pthread_join(bidcosThread, NULL);
        pthread_join(keepaliveThread, NULL);
        pthread_attr_destroy( &pthAttr );
        close( g_serverKeepAliveFd );
        close( g_serverBidcosFd );
        close( g_termEventFd );
    }
    resetCoPro();
    close( g_serialFd );

    
    return 0;
}
