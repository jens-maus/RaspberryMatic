compiler = meson.get_compiler('c')
sbinddir = join_paths(get_option('prefix'), get_option('sbindir'))
moduledir = join_paths(get_option('prefix'), get_option('moduledir'))

include_base_paths = [
	'/usr/include',
	'/usr/local/include',
#	'/opt/local/include',
]

defs = [
	'-D_TIME_BITS=64',
	'-D_FILE_OFFSET_BITS=64',
	'-D_LARGEFILE_SOURCE',
	'-D_LARGE_FILES',
	'-D_GNU_SOURCE',
]

socket_libs = []
if target_machine.system() == 'windows'
	socket_libs = [ compiler.find_library('ws2_32') ]
	defs += [
		'-DNVALGRIND',
	]
endif
if target_machine.system() == 'sunos'
	socket_libs = [ compiler.find_library('socket')
	              , compiler.find_library('nsl')
	              ]
elif target_machine.system() == 'haiku'
	socket_libs = [ compiler.find_library('network') ]
endif


conf_data = configuration_data()

conf_data.set('HAVE_SYS_INOTIFY_H', compiler.has_header('sys/inotify.h'))
conf_data.set('HAVE_SYS_LOADAVG_H', compiler.has_header('sys/loadavg.h'))
conf_data.set('HAVE_SYS_POLL_H', compiler.has_header('sys/poll.h'))
conf_data.set('HAVE_SYS_PRCTL_H', compiler.has_header('sys/prctl.h'))
conf_data.set('HAVE_SYS_PROCCTL_H', compiler.has_header('sys/procctl.h'))
conf_data.set('HAVE_SYS_SENDFILE_H', compiler.has_header('sys/sendfile.h'))
conf_data.set('HAVE_SYS_UN_H', compiler.has_header('sys/un.h'))
conf_data.set('HAVE_SYS_WAIT_H', compiler.has_header('sys/wait.h'))
conf_data.set('HAVE_SYS_TIME_H', compiler.has_header('sys/time.h'))
conf_data.set('HAVE_UNISTD_H', compiler.has_header('unistd.h'))
conf_data.set('HAVE_PTHREAD_H', compiler.has_header('pthread.h'))
conf_data.set('HAVE_DLFCN_H', compiler.has_header('dlfcn.h'))
conf_data.set('HAVE_GETOPT_H', compiler.has_header('getopt.h'))
conf_data.set('HAVE_INTTYPES_H', compiler.has_header('inttypes.h'))
conf_data.set('HAVE_POLL_H', compiler.has_header('poll.h'))
conf_data.set('HAVE_PWD_H', compiler.has_header('pwd.h'))
conf_data.set('HAVE_STDINT_H', compiler.has_header('stdint.h'))
conf_data.set('HAVE_STDLIB_H', compiler.has_header('stdlib.h'))
conf_data.set('HAVE_STRINGS_H', compiler.has_header('strings.h'))
conf_data.set('HAVE_SYSLOG_H', compiler.has_header('syslog.h'))

# will be needed for auth
conf_data.set('HAVE_CRYPT_H', compiler.has_header('crypt.h'))
if conf_data.get('HAVE_CRYPT_H')
	# check if we need libcrypt for crypt_r / crypt

	# crypt_r in default libs?
	if compiler.has_function('crypt_r', args: defs, prefix: '#include <crypt.h>')
		libcrypt = []
		conf_data.set('HAVE_CRYPT_R', 1)
	# crypt_r in -lcrypt ?
	elif compiler.has_function('crypt_r', args: defs + ['-lcrypt'], prefix: '#include <crypt.h>')
		libcrypt = [ compiler.find_library('crypt') ]
		conf_data.set('HAVE_CRYPT_R', 1)
	# crypt in default libs?
	elif compiler.has_function('crypt', args: defs, prefix: '#include <crypt.h>')
		libcrypt = []
		conf_data.set('HAVE_CRYPT', 1)
	# crypt in -lcrypt ?
	elif compiler.has_function('crypt', args: defs + ['-lcrypt'], prefix: '#include <crypt.h>')
		libcrypt = [ compiler.find_library('crypt') ]
		conf_data.set('HAVE_CRYPT', 1)
	endif
elif conf_data.get('HAVE_UNISTD_H')
	# crypt in default libs?
	if compiler.has_function('crypt', args: defs, prefix: '#include <unistd.h>')
		libcrypt = []
		conf_data.set('HAVE_CRYPT', 1)
	# crypt in -lcrypt ?
	elif compiler.has_function('crypt', args: defs + ['-lcrypt'], prefix: '#include <unistd.h>')
		libcrypt = [ compiler.find_library('crypt') ]
		conf_data.set('HAVE_CRYPT', 1)
	endif
endif

conf_data.set('HAVE_SOCKLEN_T', compiler.has_type('socklen_t', args: defs, prefix: '#include <sys/socket.h>'))

conf_data.set('HAVE_MALLOC_H', compiler.has_header('malloc.h'))
if conf_data.get('HAVE_MALLOC_H')
conf_data.set('HAVE_MALLOC_TRIM', compiler.has_function('malloc_trim', args: defs))
conf_data.set('HAVE_MALLOPT', compiler.has_function('mallopt', args: defs))
endif

if compiler.has_header('signal.h')
conf_data.set('HAVE_SIGACTION', compiler.has_function('sigaction', args: defs))
conf_data.set('HAVE_SIGNAL', compiler.has_function('signal', args: defs))
endif

conf_data.set('HAVE_SYS_EPOLL_H', compiler.has_header('sys/epoll.h'))
if conf_data.get('HAVE_SYS_EPOLL_H')
conf_data.set('HAVE_EPOLL_CTL', compiler.has_function('epoll_ctl', args: defs))
endif

conf_data.set('HAVE_SYS_EVENT_H', compiler.has_header('sys/event.h'))
if conf_data.get('HAVE_SYS_EVENT_H')
conf_data.set('HAVE_KQUEUE', compiler.has_function('kqueue', args: defs))
endif

conf_data.set('HAVE_SYS_MMAN_H', compiler.has_header('sys/mman.h'))
if conf_data.get('HAVE_SYS_MMAN_H')
conf_data.set('HAVE_MMAP', compiler.has_function('mmap', args: defs))
endif

conf_data.set('HAVE_SYS_RANDOM_H', compiler.has_header('sys/random.h'))
if conf_data.get('HAVE_SYS_RANDOM_H')
	conf_data.set('HAVE_GETENTROPY', compiler.has_function(
		'getentropy',
		args: defs,
		prefix: '#include <sys/random.h>'
	))
endif

conf_data.set('HAVE_LINUX_RANDOM_H', compiler.has_header('linux/random.h'))
if conf_data.get('HAVE_LINUX_RANDOM_H')
	conf_data.set('HAVE_GETRANDOM', compiler.has_function(
		'getrandom',
		args: defs,
		prefix: '#include <linux/random.h>'
	))
endif

conf_data.set('HAVE_SYS_RESOURCE_H', compiler.has_header('sys/resource.h'))
if conf_data.get('HAVE_SYS_RESOURCE_H')
conf_data.set('HAVE_GETRLIMIT', compiler.has_function('getrlimit', args: defs))
endif

conf_data.set('HAVE_SYS_UIO_H', compiler.has_header('sys/uio.h'))
if conf_data.get('HAVE_SYS_UIO_H')
conf_data.set('HAVE_PREADV', compiler.has_function('preadv', args: defs))
conf_data.set('HAVE_PWRITEV', compiler.has_function('pwritev', args: defs))
conf_data.set('HAVE_WRITEV', compiler.has_function('writev', args: defs))
endif

conf_data.set('HAVE_POLL', compiler.has_function('poll', args: defs))
if not(conf_data.get('HAVE_POLL'))
conf_data.set('HAVE_SYS_SELECT_H', compiler.has_header('sys/select.h'))
conf_data.set('HAVE_SELECT', compiler.has_function('select', args: defs))
endif

if target_machine.system() == 'sunos'
conf_data.set('HAVE_PORT_H', compiler.has_header('port.h'))
conf_data.set('HAVE_PRIV_H', compiler.has_header('priv.h'))
conf_data.set('HAVE_SYS_DEVPOLL_H', compiler.has_header('sys/devpoll.h'))
conf_data.set('HAVE_SYS_FILIO_H', compiler.has_header('sys/filio.h'))
conf_data.set('HAVE_PORT_CREATE', compiler.has_function('port_create', args: defs))
conf_data.set('HAVE_SENDFILEV', compiler.has_function('sendfilev', args: defs))
conf_data.set('HAVE_SETPFLAGS', compiler.has_function('setpflags', args: defs))
endif

conf_data.set('SIZEOF_LONG', compiler.sizeof('long', args: defs))
conf_data.set('SIZEOF_OFF_T', compiler.sizeof('off_t', args: defs))

conf_data.set('HAVE_ARC4RANDOM_BUF', compiler.has_function('arc4random_buf', args: defs))
conf_data.set('HAVE_CHROOT', compiler.has_function('chroot', args: defs))
conf_data.set('HAVE_COPY_FILE_RANGE', compiler.has_function('copy_file_range', args: defs))
conf_data.set('HAVE_FORK', compiler.has_function('fork', args: defs))
conf_data.set('HAVE_GETLOADAVG', compiler.has_function('getloadavg', args: defs))
conf_data.set('HAVE_GETUID', compiler.has_function('getuid', args: defs))
conf_data.set('HAVE_GMTIME_R', compiler.has_function('gmtime_r', args: defs))
conf_data.set('HAVE_INET_ATON', compiler.has_function('inet_aton', args: defs))
conf_data.set('HAVE_INET_PTON', compiler.has_function('inet_pton', args: defs))
conf_data.set('HAVE_JRAND48', compiler.has_function('jrand48', args: defs))
conf_data.set('HAVE_LOCALTIME_R', compiler.has_function('localtime_r', args: defs))
conf_data.set('HAVE_LSTAT', compiler.has_function('lstat', args: defs))
conf_data.set('HAVE_MADVISE', compiler.has_function('madvise', args: defs))
conf_data.set('HAVE_MEMPCPY', compiler.has_function('mempcpy', args: defs, prefix: '#include <string.h>'))
conf_data.set('HAVE_MKOSTEMP', compiler.has_function('mkostemp', args: defs))
conf_data.set('HAVE_PIPE2', compiler.has_function('pipe2', args: defs))
conf_data.set('HAVE_PREAD', compiler.has_function('pread', args: defs))
conf_data.set('HAVE_PWRITE', compiler.has_function('pwrite', args: defs))
conf_data.set('HAVE_SENDFILE', compiler.has_function('sendfile', args: defs))
conf_data.set('HAVE_SENDFILE64', compiler.has_function('sendfile64', args: defs))
conf_data.set('HAVE_SPLICE', compiler.has_function('splice', args: defs))
conf_data.set('HAVE_SRANDOM', compiler.has_function('srandom', args: defs))
conf_data.set('HAVE_STRERROR_R', compiler.has_function('strerror_r', args: defs))
conf_data.set('HAVE_TIMEGM', compiler.has_function('timegm', args: defs))
conf_data.set('HAVE_ISSETUGID', compiler.has_function('issetugid', args: defs))
conf_data.set('HAVE_MEMSET_S', compiler.has_function('memset_s', args: defs))
conf_data.set('HAVE_EXPLICIT_BZERO', compiler.has_function('explicit_bzero', args: defs))
conf_data.set('HAVE_EXPLICIT_MEMSET', compiler.has_function('explicit_memset', args: defs))

conf_data.set('HAVE_CLOCK_GETTIME', compiler.has_header_symbol('time.h', 'clock_gettime'))
clock_lib = []
if not(conf_data.get('HAVE_CLOCK_GETTIME'))
	if compiler.has_function('clock_gettime', args: defs + ['-lrt'], prefix: '#include <time.h>')
		conf_data.set('HAVE_CLOCK_GETTIME', true)
		clock_lib = [ compiler.find_library('rt') ]
	endif
endif

libelftc = []
if compiler.has_function('elftc_copyfile', args: defs + ['-lelftc'], prefix: '#include <libelftc.h>')
	conf_data.set('HAVE_ELFTC_COPYFILE', true)
	libelftc = [ compiler.find_library('elftc') ]
endif

conf_data.set('HAVE_IPV6', compiler.compiles('''
	#include <sys/types.h>
	#include <sys/socket.h>
	#include <netinet/in.h>

	int main() {
		struct sockaddr_in6 s; struct in6_addr t=in6addr_any; int i=AF_INET6; s; t.s6_addr[0] = 0;
		return 0;
	}
''',
	name: 'IPv6 support',
	args: defs
))

conf_data.set('HAVE_WEAK_SYMBOLS', compiler.compiles('''
	__attribute__((weak)) void __dummy(void *x) { }
	int main() {
		void *x;
		__dummy(x);
	}
''',
	name: 'weak symbols',
	args: defs
))

conf_data.set('HAVE_STRUCT_TM_GMTOFF', compiler.compiles('''
	#include <time.h>
	int main(void) {
		struct tm t;
		t.tm_gmtoff = 0;
		return 0;
	}
''',
	name: 'struct tm gmt offset',
	args: defs
))

conf_data.set('LIGHTTPD_VERSION_ID', 10400)
conf_data.set_quoted('PACKAGE_NAME', meson.project_name())
conf_data.set_quoted('PACKAGE_VERSION', meson.project_version())
conf_data.set_quoted('LIBRARY_DIR', moduledir)

conf_data.set('LIGHTTPD_STATIC', get_option('build_static'))
libdl = []
if not(get_option('build_static'))
	if target_machine.system() != 'windows'
		libdl = [ compiler.find_library('dl', required: false) ]
		if not(compiler.has_function('dlopen', args: defs, dependencies: libdl, prefix: '#include <dlfcn.h>'))
			error('Couldn\'t find dlfcn.h or dlopen in lib dl')
		endif
	endif
endif

libbrotli = []
if get_option('with_brotli')
	libbrotli = [ compiler.find_library('brotlienc') ]
	if compiler.has_function('BrotliEncoderCreateInstance', args: defs, dependencies: libbrotli, prefix: '#include <brotli/encode.h>')
		conf_data.set('HAVE_BROTLI_ENCODE_H', true)
		conf_data.set('HAVE_BROTLI', true)
	else
		error('Couldn\'t find brotli header / library')
	endif
endif

libbz2 = []
if get_option('with_bzip')
	libbz2 = [ compiler.find_library('bz2') ]
	if compiler.has_function('BZ2_bzCompress', args: defs, dependencies: libbz2, prefix: '#include <bzlib.h>')
		conf_data.set('HAVE_BZLIB_H', true)
		conf_data.set('HAVE_LIBBZ2', true)
	else
		error('Couldn\'t find bz2 header / library')
	endif
endif

if get_option('with_dbi')
	libdbi = dependency('dbi', required: false)
	if libdbi.found()
		libdbi = [ libdbi ]
	else
		libdbi = [ compiler.find_library('dbi') ]
		if not(compiler.has_function('dbi_conn_connect', args: defs, dependencies: libdbi, prefix: '#include <dbi/dbi.h>'))
			error('Couldn\'t find dbi/dbi.h or dbi_conn_connect in lib dbi')
		endif
	endif
	conf_data.set('HAVE_DBI', true)
endif

libfam = []
if get_option('with_fam') and not(conf_data.get('HAVE_SYS_INOTIFY_H'))
	libfam = [ compiler.find_library('fam') ]
	if not(compiler.has_function('FAMOpen2', args: defs, dependencies: libfam, prefix: '#include <fam.h>'))
		error('Couldn\'t find fam.h or FAMOpen2 in lib fam')
	endif
	conf_data.set('HAVE_FAM_H', true)
endif

libmaxminddb = []
if get_option('with_maxminddb')
	libmaxminddb = [ compiler.find_library('maxminddb') ]
	if not(compiler.has_function('MMDB_open', args: defs, dependencies: libmaxminddb, prefix: '#include <maxminddb.h>'))
		error('Couldn\'t find maxminddb.h or MMDB_open in lib maxminddb')
	endif
endif

libkrb5 = []
libgssapi_krb5 = []
if get_option('with_krb5')
	libkrb5 = dependency('krb5', required: false)
	if libkrb5.found()
		libkrb5 = [ libkrb5 ]
	else
		libkrb5 = [ compiler.find_library('krb5') ]
		if not(compiler.has_function('krb5_init_context', args: defs, dependencies: libkrb5))
			error('Couldn\'t find krb5_init_context in lib krb5')
		endif
	endif

	libgssapi_krb5 = dependency('krb5-gssapi', required: false)
	if libgssapi_krb5.found()
		libgssapi_krb5 = [ libgssapi_krb5 ]
	else
		libgssapi_krb5 = [ compiler.find_library('gssapi_krb5') ]
	endif

	conf_data.set('HAVE_KRB5', true)
endif

libldap = []
liblber = []
if get_option('with_ldap')
	libldap = [ compiler.find_library('ldap') ]
	if not(compiler.has_function('ldap_sasl_bind_s',
		args: defs,
		dependencies: libldap,
		prefix: '''
			#include <ldap.h>
		'''
	))
		error('Couldn\'t find ldap.h or ldap_bind in lib libldap')
	endif
	conf_data.set('HAVE_LDAP_H', true)
	conf_data.set('HAVE_LIBLDAP', true)
	liblber = [ compiler.find_library('lber') ]
	if not(compiler.has_function('ber_printf', args: defs, dependencies: liblber, prefix: '#include <lber.h>'))
		error('Couldn\'t find lber.h or ber_printf in lib liblber')
	endif
	conf_data.set('HAVE_LBER_H', true)
	conf_data.set('HAVE_LIBLBER', true)
endif

libpam = []
if get_option('with_pam')
	libpam = [ compiler.find_library('pam') ]
	if not(compiler.has_function('pam_start',
		args: defs,
		dependencies: libpam,
		prefix: '''
			#include <security/pam_appl.h>
		'''
	))
		error('Couldn\'t find security/pam_appl.h or pam_start in lib libpam')
	endif
	conf_data.set('HAVE_PAM', true)
endif

libev = []
if get_option('with_libev')
	libev = dependency('ev', required: false)
	if libev.found()
		libev = [ libev ]
	elif compiler.has_header('ev.h') and compiler.has_function('ev_time', args: defs + ['-lev'])
		libev = [ compiler.find_library('ev') ]
	else
		error('Couldn\'t find libev header / library')
	endif
	conf_data.set('HAVE_LIBEV', true)
endif

libunwind = []
if get_option('with_libunwind')
	libunwind = [ dependency('libunwind') ]
endif

liblua = []
if get_option('with_lua')
	found_lua = false
	foreach l: ['lua5.4', 'lua-5.4', 'lua5.3', 'lua-5.3', 'lua5.2', 'lua-5.2', 'lua5.1', 'lua-5.1', 'lua']
		if not(found_lua)
			liblua = dependency(l, required: false)
			if (liblua.found())
				found_lua = true
			else
				liblua = compiler.find_library(l, required: false)
				if (liblua.found())
					found_lua = true
					liblua_found_header = false
					foreach ib: include_base_paths
						if not(liblua_found_header)
							i = join_paths(ib, l)
							if compiler.has_header(join_paths(i, 'lua.h'))
								liblua_found_header = true
								liblua += [ declare_dependency(include_directories: include_directories(i)) ]
							endif
						endif
					endforeach
				endif
			endif
		endif
	endforeach
	if not(found_lua)
		error('Couldn\'t find any lua library')
	endif
	liblua = [ liblua ]
	conf_data.set('HAVE_LUA_H', true)
endif

libmysqlclient = []
if get_option('with_mysql')
	# manual search: extend include path with 'mysql/'
	# header: mysql.h
	# function: mysql_real_connect (-lmariadb)
	libmysqlclient = [ dependency('libmariadb') ]
	#-# function: mysql_real_connect (-lmysqlclient)
	#-libmysqlclient = [ dependency('mysqlclient') ]
	conf_data.set('HAVE_MYSQL', true)
endif

libssl = []
libcrypto = []
libsslcrypto = []
libgnutls = []
libmbedtls = []
libmbedcrypto = []
libmbedx509 = []
libwolfssl = []
if get_option('with_openssl')
	# manual search:
	# header: openssl/ssl.h
	# function: SSL_new (-lssl)
	# function: RAND_bytes (-lcrypto)
	libssl = [ dependency('libssl') ]
	libsslcrypto = [ dependency('libcrypto') ]
	libcrypto = [ dependency('libcrypto') ]
	conf_data.set('HAVE_OPENSSL_SSL_H', true)
	conf_data.set('HAVE_LIBSSL', true)
endif
if get_option('with_wolfssl')
	# manual search:
	# header: wolfssl/ssl.h
	# function: wolfSSL_Init (-lwolfssl)
	libwolfssl = [ dependency('wolfssl') ]
	libcrypto = [ dependency('wolfssl') ]
	conf_data.set('HAVE_WOLFSSL_SSL_H', true)
endif
if get_option('with_mbedtls')
	# manual search:
	# header: mbedtls/ssl.h
	# function: mbedtls_ssl_init (-lmbedtls)
	# function: mbedtls_x509_get_name (-lmbedx509)
	# function: mbedtls_base64_encode (-lmbedcrypto)
	libmbedtls = [ compiler.find_library('mbedtls') ]
	libmbedx509 = [ compiler.find_library('mbedx509') ]
	libmbedcrypto = [ compiler.find_library('mbedcrypto') ]
	libcrypto = [ compiler.find_library('mbedcrypto') ]
	conf_data.set('HAVE_LIBMBEDCRYPTO', true)
endif
if get_option('with_nettle')
	# manual search:
	# header: nettle/nettle-types.h
	# function: nettle_md5_init (-lnettle)
	libcrypto = [ dependency('nettle') ]
	conf_data.set('HAVE_NETTLE_NETTLE_TYPES_H', true)
endif
if get_option('with_gnutls')
	# manual search:
	# header: gnutls/gnutls.h
	# function: gnutls_check_version (-lgnutls)
	libgnutls = [ dependency('gnutls') ]
	conf_data.set('HAVE_GNUTLS_CRYPTO_H', true)
	if not(get_option('with_openssl')) and not(get_option('with_wolfssl')) and not(get_option('with_mbedtls')) and not(getoption('with_nettle'))
	  libcrypto = [ dependency('gnutls') ]
	endif
endif
libssl3 = []
libsmime3 = []
libnss3 = []
libnssutil3 = []
if get_option('with_nss')
	# manual search:
	# header: nss3/nss.h
	# function: NSSSSL_GetVersion (-lssl3)
	# function: NSSSMIME_GetVersion (-lsmime3)
	# function: NSS_GetVersion (-lnss3)
	# function: NSSUTIL_GetVersion (-lnssutil3)
	libnss3 = [ dependency('nss') ]
	#libssl3 = [ compiler.find_library('ssl3') ]
	#libsmime3 = [ compiler.find_library('smime3') ]
	#libnss3 = [ compiler.find_library('nss3') ]
	#libnssutil3 = [ compiler.find_library('nssutil3') ]
	conf_data.set('HAVE_NSS3_NSS_H', true)
	if not(get_option('with_openssl')) and not(get_option('with_wolfssl')) and not(get_option('with_mbedtls')) and not(getoption('with_nettle')) and not(getoption('with_gnutls'))
	  libcrypto = [ dependency('nss') ]
	endif
endif
if get_option('with_nss')
	# manual search:
	# header: nss/nss.h
	conf_data.set('HAVE_NSS_NSS_H', true)
endif

libpcre = []
if get_option('with_pcre2') and not(get_option('with_pcre'))
	# manual search:
	# header: pcre2.h
	# function: pcre_match (-lpcre2-8)
	libpcre = dependency('libpcre2-8', required: false)
	if libpcre.found()
		libpcre = [ libpcre ]
	else
		libpcre = [ compiler.find_library('pcre2-8', required: true) ]
	endif
	conf_data.set('HAVE_PCRE2_H', true)
	conf_data.set('HAVE_PCRE', true)
elif get_option('with_pcre')
	# manual search:
	# header: pcre.h
	# function: pcre_exec (-lpcre)
	libpcre = dependency('libpcre', required: false)
	if libpcre.found()
		libpcre = [ libpcre ]
	else
		libpcre = [ compiler.find_library('pcre', required: true) ]
	endif
	conf_data.set('HAVE_PCRE_H', true)
	conf_data.set('HAVE_PCRE', true)
endif

libpq = []
if get_option('with_pgsql')
	# manual search:
	# header: libpq-fe.h
	# function: PQsetdbLogin (-lpq)
	libpq = [ dependency('libpq') ]
	conf_data.set('HAVE_PGSQL', true)
endif

if get_option('with_sasl')
	libsasl = dependency('sasl2', required: false)
	if libsasl.found()
		libsasl = [ libsasl ]
	else
		libsasl = [ compiler.find_library('sasl2') ]
		if not(compiler.has_function('sasl_server_init', args: defs, dependencies: libsasl, prefix: '#include <sasl/sasl.h>'))
			error('Couldn\'t find sasl/sasl.h or sasl_server_init in libsasl2')
		endif
	endif
	conf_data.set('HAVE_SASL', true)
endif

#if get_option('with_valgrind')
#endif

libuuid = []
if get_option('with_webdav_locks')
	libuuid = dependency('uuid', required: false)
	if libuuid.found()
		libuuid = [ libuuid ]
	elif compiler.has_function('uuid_generate', args: defs, prefix: '#include <uuid/uuid.h>')
		# uuid_generate in libc, everything is fine, no lib needed
		libuuid = []
	else
		libuuid = compiler.find_library('uuid')
		if not(compiler.has_function('uuid_generate',
			args: defs,
			dependencies: libuuid,
			prefix: '#include <uuid/uuid.h>'
		))
			error('Couldn\'t find uuid/uuid.h or uuid_generate in lib c and uuid')
		endif
	endif
	conf_data.set('HAVE_LIBUUID', true)
	conf_data.set('HAVE_UUID_UUID_H', true)
endif

libxml2 = []
libsqlite3 = []
if get_option('with_webdav_props')
	libxml2 = dependency('libxml-2.0', required: false)
	if libxml2.found()
		libxml2 = [ libxml2 ]
	else
		libxml2_includes = []
		libxml2_includes_dep = []
		libxml2_found_header = compiler.has_header('libxml/tree.h')
		foreach i: include_base_paths
			if not(libxml2_found_header)
				message('Searching in ' + join_paths(i, 'libxml2'))
				i = include_directories(join_paths(i, 'libxml2'))
				if compiler.has_header('libxml/tree.h', include_directories: i)
					libxml2_found_header = true
					libxml2_includes = [ i ]
					libxml2_includes_dep = [ declare_dependency(include_directories: i) ]
				endif
			endif
		endforeach
		if not(libxml2_found_header)
			error('Couldn\'t find libxml/tree.h')
		endif
		libxml2 = [ compiler.find_library('xml2') ]
		if not(compiler.has_function('xmlParseChunk',
			args: defs,
			dependencies: libxml2,
			include_directories: libxml2_includes,
			prefix: '''
				#include <libxml/tree.h>
			'''
		))
			error('Couldn\'t find xmlParseChunk in lib xml2')
		endif
		# has_function doesn't like "internal dependencies"
		libxml2 += libxml2_includes_dep
	endif
	conf_data.set('HAVE_LIBXML2', true)
	conf_data.set('HAVE_LIBXML_H', true)

	libsqlite3 = dependency('sqlite31', required: false)
	if libsqlite3.found()
		libsqlite3 = [ libsqlite3 ]
	else
		libsqlite3 = [ compiler.find_library('sqlite3') ]
		if not(compiler.has_function('sqlite3_reset',
			args: defs,
			dependencies: libsqlite3,
			prefix: '''
				#include <sqlite3.h>
			'''
		))
			error('Couldn\'t find sqlite3.h or sqlite3_reset in lib sqlite3')
		endif
	endif
	conf_data.set('HAVE_SQLITE3_H', true)
endif

libattr = []
if get_option('with_xattr')
    if compiler.has_function('getxattr',
		args: defs,
		prefix: '''
			#include <sys/types.h>
			#include <sys/xattr.h>
		'''
    )
	conf_data.set('HAVE_SYS_XATTR_H', true)
	conf_data.set('HAVE_XATTR', true)
    elif compiler.has_function('extattr_get_file',
		args: defs,
		prefix: '''
			#include <sys/types.h>
			#include <sys/extattr.h>
		'''
    )
	conf_data.set('HAVE_SYS_EXTATTR_H', true)
	conf_data.set('HAVE_EXTATTR', true)
    else
	libattr = [ compiler.find_library('attr') ]
	if not(compiler.has_function('attr_get',
		args: defs,
		dependencies: libattr,
		prefix: '''
			#include <sys/types.h>
			#include <attr/attributes.h>
		'''
	))
		error('Couldn\'t find attr/attributes.h or attr_get in lib attr')
	endif
	conf_data.set('HAVE_ATTR_ATTRIBUTES_H', true)
	conf_data.set('HAVE_XATTR', true)
    endif
endif

libxxhash = []
if get_option('with_xxhash')
	libxxhash = dependency('libxxhash', required: false)
	if libxxhash.found()
		libxxhash = [ libxxhash ]
	else
		libxxhash = [ compiler.find_library('xxhash') ]
		if not(compiler.has_function('XXH_versionNumber', args: defs, dependencies: libxxhash, prefix: '#include <xxhash.h>'))
			error('Couldn\'t find xxhash/xxhash.h or XXH_versionNumber in lib xxhash')
		endif
	endif
	conf_data.set('HAVE_XXHASH_H', true)
endif

libz = []
if get_option('with_zlib')
	libz = dependency('zlib', required: false)
	if libz.found()
		libz = [ libz ]
	else
		# windows alternative names? 'zlib', 'zdll'
		libz = [ compiler.find_library('z') ]
		if not(compiler.has_function('deflate', args: defs, dependencies: libz, prefix: '#include <zlib.h>'))
			error('Couldn\'t find z header / library')
		endif
	endif
	conf_data.set('HAVE_ZLIB_H', true)
	conf_data.set('HAVE_LIBZ', true)
endif

libzstd = []
if get_option('with_zstd')
	libzstd = dependency('zstd', required: false)
	if libzstd.found()
		libzstd = [ libzstd ]
	else
		libzstd = [ compiler.find_library('zstd') ]
		if not(compiler.has_function('ZSTD_versionNumber', args: defs, dependencies: libzstd, prefix: '#include <zstd.h>'))
			error('Couldn\'t find zstd header / library')
		endif
	endif
	conf_data.set('HAVE_ZSTD_H', true)
	conf_data.set('HAVE_ZSTD', true)
endif

configure_file(
	output : 'config.h',
	configuration : conf_data,
)

common_src = [
	'algo_md5.c',
	'algo_sha1.c',
	'algo_splaytree.c',
	'array.c',
	'base64.c',
	'buffer.c',
	'burl.c',
	'chunk.c',
	'configfile-glue.c',
	'http_etag.c',
	'fdevent.c',
	'fdevent_fdnode.c',
	'fdlog_maint.c',
	'fdlog.c',
	'gw_backend.c',
	'http_cgi.c',
	'http_chunk.c',
	'http_date.c',
	'http_header.c',
	'http_kv.c',
	'http-header-glue.c',
	'keyvalue.c',
	'log.c',
	'plugin.c',
	'rand.c',
	'request.c',
	'ck.c',
	'sock_addr.c',
	'stat_cache.c',
	'vector.c',
]
if target_machine.system() == 'windows'
	common_src += [ 'xgetopt.c' ]
endif
main_src = [
	'configfile.c',
	'connections.c',
	'data_config.c',
	'h2.c',
	'sock_addr_cache.c',
	'ls-hpack/lshpack.c',
	'algo_xxhash.c',
	'fdevent_impl.c',
	'http_range.c',
	'network_write.c',
	'network.c',
	'reqpool.c',
	'response.c',
	'server.c',
]

lemon = executable('lemon',
	sources: 'lemon.c',
	native: true,
)
# generator doesn't handle additional "input dependencies" like lempar.c
# => use custom_target
configparser = custom_target('configparser',
	input:  ['configparser.y', 'lempar.c'],
	output: ['configparser.c', 'configparser.h'],
	command: [lemon, '-q', 'o=@OUTDIR@', '@INPUT0@', '@INPUT1@'],
)

common_cflags = defs + [
	'-DHAVE_CONFIG_H',
]

if compiler.get_id() == 'gcc' or compiler.get_id() == 'clang'
	common_cflags += [
		'-pipe',
		'-Wall',
		'-g',
		'-Wshadow',
		'-W',
		'-pedantic',
	]
	if get_option('build_extra_warnings')
		common_cflags += get_option('warn_cflags').split()
	endif
endif

common_flags = [ declare_dependency(
	compile_args: common_cflags,
	# tests also use common_flags, and need this
	include_directories: include_directories('.'),
) ]

lighttpd_flags = []
lighttpd_angel_flags = []
if target_machine.system() == 'windows'
	lighttpd_flags += [ declare_dependency(
		compile_args: [
			'-DLI_DECLARE_EXPORTS',
		],
	) ]
	if compiler.get_id() == 'gcc'
		libmsvcr70 = [ compiler.find_library('msvcr70') ]
		lighttpd_flags += libmsvcr70 + [ declare_dependency(
			link_args: [
				'-Wl,-subsystem,console',
			],
		) ]
		lighttpd_angel_flags += libmsvcr70 + [ declare_dependency(
			link_args: [
				'-Wl,-subsystem,console',
			],
		) ]
	endif
endif

if (compiler.get_id() == 'gcc' or compiler.get_id() == 'clang') and target_machine.system() != 'darwin' and target_machine.system() != 'sunos'
	lighttpd_flags += [ declare_dependency(
		link_args: [
			'-Wl,-export-dynamic',
		],
	) ]
endif

executable('lighttpd-angel',
	sources: 'lighttpd-angel.c',
	dependencies: common_flags + lighttpd_angel_flags,
	c_args: ['-DSBIN_DIR="' + sbinddir + '"'],
	install: true,
	install_dir: sbinddir,
)

executable('lighttpd', configparser,
	sources: common_src + main_src,
	dependencies: [ common_flags, lighttpd_flags
		, libattr
		, libcrypto
		, libdl
		, libev
		, libfam
		, libpcre
		, libunwind
		, libxxhash
		, socket_libs
		, clock_lib
	],
	install: true,
	install_dir: sbinddir,
)

test('test_common', executable('test_common',
	sources: [
		't/test_common.c',
		't/test_array.c',
		't/test_base64.c',
		't/test_buffer.c',
		't/test_burl.c',
		't/test_keyvalue.c',
		't/test_request.c',
		'http_header.c',
		'http_kv.c',
		'log.c',
		'fdlog.c',
		'sock_addr.c',
		'ck.c',
	],
	dependencies: [ common_flags
		, libpcre
		, libunwind
		, socket_libs
		, clock_lib
	],
	build_by_default: false,
))

test('test_configfile', executable('test_configfile',
	sources: [
		't/test_configfile.c',
		'buffer.c',
		'array.c',
		'data_config.c',
		'http_header.c',
		'http_kv.c',
		'vector.c',
		'log.c',
		'fdlog.c',
		'sock_addr.c',
		'ck.c',
	],
	dependencies: [ common_flags
		, libpcre
		, libunwind
		, socket_libs
		, clock_lib
	],
	build_by_default: false,
))

test('test_mod', executable('test_mod',
	sources: [
		common_src,
		't/test_mod.c',
		't/test_mod_access.c',
		't/test_mod_alias.c',
		't/test_mod_evasive.c',
		't/test_mod_evhost.c',
		't/test_mod_indexfile.c',
		't/test_mod_simple_vhost.c',
		't/test_mod_ssi.c',
		't/test_mod_staticfile.c',
		't/test_mod_userdir.c',
	],
	dependencies: [ common_flags, lighttpd_flags
		, libattr
		, libcrypto
		, libdl
		, libev
		, libfam
		, libpcre
		, libunwind
		, libxxhash
		, socket_libs
		, clock_lib
	],
	build_by_default: false,
))

modules = [
	[ 'mod_access', [ 'mod_access.c' ] ],
	[ 'mod_accesslog', [ 'mod_accesslog.c' ] ],
	[ 'mod_ajp13', [ 'mod_ajp13.c' ] ],
	[ 'mod_alias', [ 'mod_alias.c' ] ],
	[ 'mod_auth', [ 'mod_auth.c', 'mod_auth_api.c' ], [ libcrypto ] ],
	[ 'mod_authn_file', [ 'mod_authn_file.c' ], [ libcrypt, libcrypto ] ],
	[ 'mod_deflate', [ 'mod_deflate.c' ], libbz2 + libz + libzstd + libbrotli ],
	[ 'mod_dirlisting', [ 'mod_dirlisting.c' ] ],
	[ 'mod_evasive', [ 'mod_evasive.c' ] ],
	[ 'mod_evhost', [ 'mod_evhost.c' ] ],
	[ 'mod_expire', [ 'mod_expire.c' ] ],
	[ 'mod_extforward', [ 'mod_extforward.c' ] ],
	[ 'mod_fastcgi', [ 'mod_fastcgi.c' ], socket_libs ],
	[ 'mod_indexfile', [ 'mod_indexfile.c' ] ],
	[ 'mod_proxy', [ 'mod_proxy.c' ], socket_libs ],
	[ 'mod_redirect', [ 'mod_redirect.c' ] ],
	[ 'mod_rewrite', [ 'mod_rewrite.c' ] ],
	[ 'mod_rrdtool', [ 'mod_rrdtool.c' ] ],
	[ 'mod_scgi', [ 'mod_scgi.c' ], socket_libs ],
	[ 'mod_secdownload', [ 'mod_secdownload.c', 'algo_hmac.c' ], libcrypto ],
	[ 'mod_setenv', [ 'mod_setenv.c' ] ],
	[ 'mod_simple_vhost', [ 'mod_simple_vhost.c' ] ],
	[ 'mod_sockproxy', [ 'mod_sockproxy.c' ] ],
	[ 'mod_ssi', [ 'mod_ssi.c' ], socket_libs ],
	[ 'mod_staticfile', [ 'mod_staticfile.c' ] ],
	[ 'mod_status', [ 'mod_status.c' ] ],
	[ 'mod_uploadprogress', [ 'mod_uploadprogress.c' ] ],
	[ 'mod_userdir', [ 'mod_userdir.c' ] ],
	[ 'mod_usertrack', [ 'mod_usertrack.c' ], libcrypto ],
	[ 'mod_vhostdb', [ 'mod_vhostdb.c', 'mod_vhostdb_api.c' ] ],
	[ 'mod_webdav', [ 'mod_webdav.c' ], libsqlite3 + libuuid + libxml2 + libelftc ],
	[ 'mod_wstunnel', [ 'mod_wstunnel.c' ], libcrypto ],
]

if target_machine.system() != 'windows'
	modules += [
		[ 'mod_cgi', [ 'mod_cgi.c' ] ],
	]
endif

if get_option('with_lua')
	modules += [
		[ 'mod_magnet', [ 'mod_magnet.c', 'mod_magnet_cache.c', 'algo_hmac.c' ], liblua + libcrypto ],
	]
endif

if get_option('with_maxminddb')
	modules += [
		[ 'mod_maxminddb', [ 'mod_maxminddb.c' ], libmaxminddb ],
	]
endif

if get_option('with_mysql')
	modules += [
		[ 'mod_vhostdb_mysql', [ 'mod_vhostdb_mysql.c' ], libmysqlclient ],
	]
endif

if get_option('with_pgsql')
	modules += [
		[ 'mod_vhostdb_pgsql', [ 'mod_vhostdb_pgsql.c' ], libpq ],
	]
endif

if get_option('with_dbi')
	modules += [
		[ 'mod_authn_dbi', [ 'mod_authn_dbi.c' ], libcrypt + libdbi + libcrypto ],
		[ 'mod_vhostdb_dbi', [ 'mod_vhostdb_dbi.c' ], libdbi ],
	]
endif

if get_option('with_krb5')
	modules += [
		[ 'mod_authn_gssapi', [ 'mod_authn_gssapi.c' ], libkrb5 + libgssapi_krb5 ],
	]
endif

if get_option('with_ldap')
	modules += [
		[ 'mod_authn_ldap', [ 'mod_authn_ldap.c' ], libldap + liblber ],
		[ 'mod_vhostdb_ldap', [ 'mod_vhostdb_ldap.c' ], libldap + liblber ],
	]
endif

if get_option('with_openssl')
	modules += [
		[ 'mod_openssl', [ 'mod_openssl.c' ], libssl + libsslcrypto ],
	]
endif

if get_option('with_wolfssl')
	modules += [
		[ 'mod_wolfssl', [ 'mod_wolfssl.c' ], libwolfssl ],
	]
endif

if get_option('with_mbedtls')
	modules += [
		[ 'mod_mbedtls', [ 'mod_mbedtls.c' ], libmbedtls + libmbedx509 + libmbedcrypto ],
	]
endif

if get_option('with_nss')
	modules += [
		[ 'mod_nss', [ 'mod_nss.c' ], libssl3 + libsmime3 + libnss3 + libnssutil3 ],
	]
endif

if get_option('with_gnutls')
	modules += [
		[ 'mod_gnutls', [ 'mod_gnutls.c' ], libgnutls ],
	]
endif

if get_option('with_pam')
	modules += [
		[ 'mod_authn_pam', [ 'mod_authn_pam.c' ], libpam ],
	]
endif

if get_option('with_sasl')
	modules += [
		[ 'mod_authn_sasl', [ 'mod_authn_sasl.c' ], libsasl ],
	]
endif

foreach mod: modules
	mod_name = mod.get(0)
	mod_sources = mod.get(1)
	mod_deps = mod.length() > 2 ? mod.get(2) : []
	shared_module(mod_name,
		sources: mod_sources,
		dependencies: [ common_flags, mod_deps ],
		name_prefix: '',
		install: true,
		install_dir: moduledir,
	)
endforeach
