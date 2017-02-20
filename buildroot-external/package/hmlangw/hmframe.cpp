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

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <termios.h>

#include "hmframe.h"


int writeall( int fd, const void *buffer, int len )
{
    int result = 0;
    while( len )
    {
        int r = write( fd, buffer, len );
        if( r == -1 )
        {
            result = r;
            break;
        }
        result += r;
        len -= r;
    }
    return result;
}

static const unsigned char enterBootloader[] =
    {
        0xfd, 0x00, 0x03, 0x00, 0x00, 0x03, 0x18, 0x0a 
    };
    
static const unsigned char bootloaderReply[] =
    {
        0xfd, 0x00, 0x0c, 0x00, 0x00, 0x00, 0x43, 0x6f, 0x5f, 0x43, 0x50, 0x55, 0x5f, 0x42, 0x4c, 0x72, 0x51 
    };

int sendEnterBootloader( int fd )
{
    int result = -1;
    while( 1 )
    {
        char buffer[80];
        tcflush(fd, TCIOFLUSH);
        result =writeall( fd, enterBootloader, sizeof( enterBootloader ) );
        if( result <= 0 )
        {
            break;
        }
        result = readBidcosFrame( fd, buffer, sizeof( buffer ) );
        if( result <= 0 )
        {
            break;
        }
        if( isBootloaderReply( buffer, result ) )
        {
            break;
        }
    }
    return result;
}

int sendBootloaderReply( int fd )
{
    return writeall( fd, bootloaderReply, sizeof( bootloaderReply ) );
}

bool isBootloaderReply( const void *buffer, int len )
{
    if( len != sizeof(bootloaderReply) )
        return false;
        
    return (memcmp( buffer, bootloaderReply, len ) == 0);
}


int readBidcosFrame( int fd, char *buffer, int bufsize )
{
    int result = 0;
    int msgLen = 0;
    int escaped = 0;
    int count = bufsize;
    unsigned char *buf = (unsigned char *)buffer;
    char escapeValue = 0x00;
    bool haveLength = false;
    
    while ( count )
    {
        int r = read( fd, buf, 1 );
        if( r <= 0 )
        {
            result = r;
            perror( "ERROR: readBidcosFrame" );
            break;
        }
        if( *buf == 0xFD ) // sync byte
        {
            result = 0;
            msgLen = 0;
            escaped = 0;
            count = bufsize;
            buf = (unsigned char *)buffer;
            escapeValue = 0x00;
            haveLength = false;
            // fprintf( stderr,  "readBidcosFrame reset\n" );
        }
        else if( result == 0 )
        {
            fprintf( stderr,  "ERROR: readBidcosFrame sync error %2.2x\n", *buf );
            // No sync at beginning? Not good...
            break;
        }
        
        result += r;
        
        if( *buf == 0xFC && result > 1 ) // escape byte
        {
            escaped++;
            escapeValue = 0x80;
            // fprintf( stderr,  "ESCAPE msgLen set %d result %d\n", msgLen, result );
        }
        else
        {
            escapeValue = 0x00;
        }

        if( false == haveLength )
        {
            if( result == 2 + escaped )
            {
                msgLen = *buf; // MSB
                msgLen |= escapeValue;
                msgLen = msgLen<<8;
            }
            else if( result == 3 + escaped )
            {
                msgLen |= *buf; // LSB
                msgLen |= escapeValue;
                haveLength = true;
                // fprintf( stderr,  "readBidcosFrame msgLen set %d result %d\n", msgLen, result );
            }
        }
        else if( result >= msgLen + escaped + 5 )
        {
            // fprintf( stderr,  "readBidcosFrame done, msgLen %d result %d\n", msgLen, result );
            break;
        }
        
        count -= r;
        buf+=r;
    }

    return result;
}
