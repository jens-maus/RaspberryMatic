/**
 * Node Sodium install script to help support Windows
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */

var https = require('https');
var fs = require('fs');
var path = require('path');
var exec = require('child_process').exec;
var os = require('os');

var libFiles = [
    'libsodium.dll',
    'libsodium.exp',
    'libsodium.lib',
    'libsodium.pdb',
];

var includeFiles = [
    'include/sodium/core.h',
    'include/sodium/crypto_aead_aes256gcm.h',
    'include/sodium/crypto_aead_chacha20poly1305.h',
    'include/sodium/crypto_auth.h',
    'include/sodium/crypto_auth_hmacsha256.h',
    'include/sodium/crypto_auth_hmacsha512.h',
    'include/sodium/crypto_auth_hmacsha512256.h',
    'include/sodium/crypto_box.h',
    'include/sodium/crypto_box_curve25519xsalsa20poly1305.h',
    'include/sodium/crypto_core_hchacha20.h',
    'include/sodium/crypto_core_hsalsa20.h',
    'include/sodium/crypto_core_salsa20.h',
    'include/sodium/crypto_core_salsa2012.h',
    'include/sodium/crypto_core_salsa208.h',
    'include/sodium/crypto_generichash.h',
    'include/sodium/crypto_generichash_blake2b.h',
    'include/sodium/crypto_hash.h',
    'include/sodium/crypto_hash_sha256.h',
    'include/sodium/crypto_hash_sha512.h',
    'include/sodium/crypto_int32.h',
    'include/sodium/crypto_int64.h',
    'include/sodium/crypto_onetimeauth.h',
    'include/sodium/crypto_onetimeauth_poly1305.h',
    'include/sodium/crypto_pwhash.h',
    'include/sodium/crypto_pwhash_argon2i.h',
    'include/sodium/crypto_pwhash_scryptsalsa208sha256.h',
    'include/sodium/crypto_scalarmult.h',
    'include/sodium/crypto_scalarmult_curve25519.h',
    'include/sodium/crypto_secretbox.h',
    'include/sodium/crypto_secretbox_xsalsa20poly1305.h',
    'include/sodium/crypto_shorthash.h',
    'include/sodium/crypto_shorthash_siphash24.h',
    'include/sodium/crypto_sign.h',
    'include/sodium/crypto_sign_ed25519.h',
    'include/sodium/crypto_sign_edwards25519sha512batch.h',
    'include/sodium/crypto_stream.h',
    'include/sodium/crypto_stream_chacha20.h',
    'include/sodium/crypto_stream_salsa20.h',
    'include/sodium/crypto_stream_salsa2012.h',
    'include/sodium/crypto_stream_salsa208.h',
    'include/sodium/crypto_stream_xsalsa20.h',
    'include/sodium/crypto_uint16.h',
    'include/sodium/crypto_uint32.h',
    'include/sodium/crypto_uint64.h',
    'include/sodium/crypto_uint8.h',
    'include/sodium/crypto_verify_16.h',
    'include/sodium/crypto_verify_32.h',
    'include/sodium/crypto_verify_64.h',
    'include/sodium/export.h',
    'include/sodium/randombytes.h',
    'include/sodium/randombytes_salsa20_random.h',
    'include/sodium/randombytes_sysrandom.h',
    'include/sodium/runtime.h',
    'include/sodium/utils.h',
    'include/sodium/version.h',
    'include/sodium.h'
];

function recursePathList(paths) {
    if (0 === paths.length) {
        return;
    }

    var file = paths.shift();
    if (!fs.existsSync(file)) {
        try {
            fs.mkdirSync(file, 0755);
        } catch (e) {
            throw new Error("Failed to create path: " + file + " with " + e.toString());
        }
    }
    recursePathList(paths);
}

function createFullPath(fullPath) {
    var normPath = path.normalize(fullPath);
    var file = '';
    var pathList = [];

    var parts = [];
    if (normPath.indexOf('/') !== -1) {
        parts = normPath.split('/');
    } else {
        parts = normPath.split('\\');
    }

    for (var i = 0, max = parts.length; i < max; i++) {
        if (parts[i]) {
            file = path.join(file, parts[i]);
            pathList.push(file);
        }
    }

    if (0 === pathList.length)
        throw new Error("Path list was empty");
    else
        recursePathList(pathList);
}

function exists(path) {
    try {
        fs.accessSync(path, fs.F_OK);
        return true;
    } catch (e) {
        return false;
    }
}

function download(url, dest, cb) {
    if(exists(dest)) {
        console.log('File ' + dest + ' alredy exists, run make clean if you want to download it again.');
        cb(null);
    }
    var file = fs.createWriteStream(dest);
    var request = https.get(url, function(response) {
        response.pipe(file);
        file.on('finish', function() {
            file.close(cb); // close() is async, call cb after close completes.
        });
    }).on('error', function(err) { // Handle errors
        fs.unlink(dest); // Delete the file async. (But we don't check the result)
        if (cb) cb(err);
    });
}

function getPlatformToolsVersion() {
    var platformTools = {
        2010: 'v100',
        2012: 'v110',
        2013: 'v120',
        2015: 'v140'
    }

    checkMSVSVersion();
    var ver = platformTools[process.env.npm_config_msvs_version];
    if (!ver) {
        throw new Error('Please set msvs_version');
    }
    return ver;
}

function downloadAll(files, baseURL, basePath, next) {
    if (0 === files.length) {
        next();
        return;
    }
    var file = files.shift();
    var url = baseURL + '/' + file;
    var path = basePath + '/' + file;
    console.log('Download: ' + url);
    download(url, path, function(err) {
        if (err) {
            throw err;
        }
        downloadAll(files, baseURL, basePath, next);
    });
}

function copyFile(source, target, cb) {
    var cbCalled = false;

    var rd = fs.createReadStream(source);
    rd.on("error", function(err) {
        done(err);
    });
    var wr = fs.createWriteStream(target);
    wr.on("error", function(err) {
        done(err);
    });
    wr.on("close", function(ex) {
        done();
    });
    rd.pipe(wr);

    function done(err) {
        if (!cbCalled) {
            cb(err);
            cbCalled = true;
        }
    }
}

function copyFiles(files, next) {
    if (0 === files.length) {
        next();
        return;
    }
    var file = files.shift();

    var from = 'deps/build/lib/' + file;
    var to = 'build/Release/' + file;
    copyFile(from, to, function(err) {
        if (err) {
            throw err;
        }
        console.log('Copy ' + from + ' to ' + to);
        copyFiles(files, next);
    })
}

function gypConfigure(next) {
    var gyp = exec('node-gyp configure');
    gyp.stdout.on('data', function(data) {
        process.stdout.write(data.toString());
    });
    gyp.stderr.on('data', function(data) {
        process.stdout.write(data.toString());
    });
    gyp.on('close', function(code) {
        console.log('Done.');
        next();
    });
}

function doDownloads(next) {
    var baseURL = 'https://raw.githubusercontent.com/paixaop/libsodium-bin/master';
    console.log('Download libsodium.lib');
    var ver = getPlatformToolsVersion();
    console.log('Platform Tool is ' + ver);
    switch (os.arch()) {
        case 'x64':
            arch = 'x64';
            break;
        case 'ia32':
            arch = 'Win32';
            break;
        default:
            throw new Error('No pre-compiled binary available for this platform ' + os.arch());
    }

    // Older versions of node-sodium will try and download from the 'root' of baseURL
    // Added libsodium_version to package.json to support multiple binary versions of
    // libsodium
    var package = require('./package.json');
    if( package.libsodium_version ) {
        baseURL += '/' + package.libsodium_version;
    }

    var libURL = baseURL + '/' + arch + '/Release/' + ver + '/dynamic';
    files = libFiles.slice(0); // clone array
    downloadAll(files, libURL, 'deps/build/lib', function() {
        console.log('Libs for version ' + ver + ' downloaded.');
        downloadAll(includeFiles, baseURL, 'deps/build', function() {
            console.log('Include files downloaded.');
            next();
        });
    });
}

function run(cmdLine, expectedExitCode, next) {
    var child = exec(cmdLine);

    if (typeof expectedExitCode === 'undefined') {
        expectedExitCode = 0;
    }

    child.stdout.on('data', function(data) {
        process.stdout.write(data.toString());
    });
    child.stderr.on('data', function(data) {
        process.stdout.write(data.toString());
    });
    child.on('exit', function(code) {
        if (code !== expectedExitCode) {
            throw new Error(cmdLine + ' exited with code ' + code);
        }
        if (!next) process.exit(0);
        next();
    });
}

function errorSetMSVSVersion() {
    console.log('Please set your Microsoft Visual Studio version before you run npm install');
    console.log('Example for Visual Studio 2015:\n');
    console.log('    For you user only:\n');
    console.log('        npm config set msvs_version 2015\n');
    console.log('    Global:\n');
    console.log('        npm config set msvs_version 2015 --global\n');
    console.log('Supported values are 2010, 2012, 2013, 2015\n');
    process.exit(1);
}

function errorInvalidMSVSVersion() {
    console.log('Invalid msvs_version ' + msvsVersion + '\n');
    console.log('Please set your Microsoft Visual Studio version before you run npm install');
    console.log('Example for Visual Studio 2015:\n');
    console.log('    For you user only:\n');
    console.log('        npm config set msvs_version 2015\n');
    console.log('    Global:\n');
    console.log('        npm config set msvs_version 2015 --global\n');
    console.log('Supported values are 2010, 2012, 2013, 2015\n');
    process.exit(1);
}

function checkMSVSVersion() {
    if (!process.env.npm_config_msvs_version) {
        errorSetMSVSVersion();
    }
    console.log('MS Version: ' + process.env.npm_config_msvs_version);
    if (process.env.npm_config_msvs_version.search(/^2010|2012|2013|2015$/)) {
        errorInvalidMSVSVersion();
    }
}

function isPreInstallMode() {
    if (!process.argv[2] || process.argv[2].search(/^--preinstall|--install/)) {
        console.log('please call install with --preinstall or --install');
        process.exit(1);
    }
    if (process.argv[2] === '--preinstall') {
        return true;
    }
    return false;
}


// Start
if (os.platform() !== 'win32') {
    if (isPreInstallMode()) {
        run('make libsodium');
    } else {
        run('make nodesodium');
    }
} else {
    checkMSVSVersion();
    if (isPreInstallMode()) {
        console.log('Preinstall Mode');
        createFullPath("deps/build/include/sodium");
        createFullPath("deps/build/lib");
        createFullPath("build/Release");
        doDownloads(function() {
            console.log('Prebuild steps completed. Binary libsodium distribution installed in ./deps/build');
            process.exit(0);
        });
    } else {
        console.log('Install Mode');
        run('node-gyp rebuild', 0, function() {
            console.log('Copy lib files to Release folder');
            files = libFiles.slice(0); // clone array
            copyFiles(files, function() {
                console.log('Done copying files.');
                process.exit(0);
            });
        });
    }
}