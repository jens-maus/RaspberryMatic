[![Build Status](https://secure.travis-ci.org/paixaop/node-sodium.png)](http://travis-ci.org/paixaop/node-sodium)

# node-sodium

Versions 2.0 and above are no longer compatible with Node 0.x. If you're still using an old version of node please use an older version of node-sodium.

Uses Libsodium 1.0.15

Port of the [lib sodium](https://github.com/jedisct1/libsodium) Encryption Library to Node.js.

As of libsodium 1.0.11 all functions except memory allocation have been implemented.
Missing functions are listed in [`docs/not implemented.md`](https://github.com/paixaop/node-sodium/blob/master/docs/not%20implemented.md).


There's a "low level" native module that gives you access directly to Lib Sodium, and a friendlier high level API that makes the library a bit easier to use.

Check [`docs/low-level-api.md`](https://github.com/paixaop/node-sodium/tree/master/docs/low-level-api.md) for a list of all lib sodium functions included in node-sodium.

# Usage

Just a quick example that uses the same public/secret key pair to encrypt and then decrypt the message.

    var sodium = require('sodium');
    var box = new sodium.Box();     // random key pair, and nonce generated automatically

    var cipherText = box.encrypt("This is a secret message", "utf8");
    var plainText = box.decrypt(cipherText);


# Low Level API
A low level API is provided for advanced users. The functions available through the low level API have the exact same names as in lib sodium, and are available via the `sodium.api` object. Here is one example of how to use some of the low level API functions to encrypt/decrypt a message:

    var sodium = require('sodium').api;

    // Generate keys
    var sender = sodium.crypto_box_keypair();
    var receiver = sodium.crypto_box_keypair();

    // Generate random nonce
    var nonce = Buffer.allocUnsafe(sodium.crypto_box_NONCEBYTES);
    sodium.randombytes_buf(nonce);

    // Encrypt
    var plainText = Buffer.from('this is a message');
    var cipherMsg = sodium.crypto_box(plainText, nonce, receiver.publicKey, sender.secretKey);

    // Decrypt
    var plainBuffer = sodium.crypto_box_open(cipherMsg,nonce,sender.publicKey, receiver.secretKey);

    // We should get the same plainText!
    if (plainBuffer.toString() == plainText) {
        console.log("Message decrypted correctly");
    }

As you can see the high level API implementation is easier to use, but the low level API will feel just right for those experienced with the C version of lib sodium. It also allows you to bypass any bugs in the high level APIs.

You can find this code sample in `examples\low-level-api.js`.

# Documentation
Please read the work in progress documentation found under [`docs/`](https://github.com/paixaop/node-sodium/tree/master/docs).

You should also review the unit tests as most of the high level API is "documented" there.
Don't forget to check out the [examples](https://github.com/paixaop/node-sodium/tree/master/examples) as well.

The low level `libsodium` API documentation is now complete. All ported functions have been documented in [low-level-api.md](./docs/low-level-api.md) with code examples.

Please be patient as I document the rest of the APIs, or better still: help out! :)

# Lib Sodium Documentation
Lib Sodium is documented [here](http://doc.libsodium.org/). Node-Sodium follows the same structure and I will keep documenting it as fast as possible.

# Install

Tested on Mac, Linux, Windows and IllumOS Systems

    npm install sodium

node-sodium depends on libsodium, so if libsodium does not compile on your platform chances are `npm install sodium` will fail.

Install can fail in some Linux distros due to permission issues. If you see an error similar to the following:

```
npm WARN lifecycle sodium@1.2.3~preinstall: cannot run in wd %s %s (wd=%s) sodium@1.2.3 node install.js --preinstall
```

Try installing with

    npm install sodium --unsafe-perm

Installation will fail if `node-gyp`is not installed on your system. Please run

    npm install node-gyp -g

Before you install `node-sodium`. If you run into permission errors while installing `node-gyp` run as Adminstrator on Windows or use `sudo` in other OSes.

	sudo npm install node-gyp -g

Compiling libsodium requires autoconf, automake and libtool so if you get an errors about these tools missing please install them. On Mac OS you can do so with:

    brew install libtool autoconf automake

If you cannot compile libsodium on Linux, try installing libtools with:

    sudo apt-get install libtool-bin

## Windows Install

Windows installs will automatically attempt to download LibSodium binary distribution, and include files, from [my repo](https://github.com/paixaop/libsodium-bin).
You MUST set the `msvs_version` `npm config` variable to the appropriate Microsoft Visual Studio version you have installed before you run `npm install` on Windows.

Example set `msvs_version` for your user only:

    npm config set msvs_version 2015

Example set `msvs_version` for all users:

    npm config set msvs_version 2015 --global

At the moment only 2010, 2012, 2013 and 2015 versions are supported.

Now run

    npm install

At the moment Windows only supports dynamic linking so you must have the `libsodium.dll` in the same directory
as `sodium.node`. This is done automatically by the install script, but if you move things around manually
please don't forget to copy the DLL file as well.

If you experience difficulty with the install even with a correctly set `msvs_version`, it may be worth trying:

    npm install npm -g
    
to upgrade npm and its bundled version of node-gyp. 

# Manual Build

Node Sodium includes the source of libsodium, so the normal install will try to compile libsodium directly from source, using libsodium's own build tools.
This is the prefered method of compiling node sodium.
If you can't compile libsodium from source in your platform you can [download a pre-compiled binary](http://www.libsodium.org/releases) and copy the libsodium.* library files to `./deps/build/lib` folder.
and copy all the include files to `./deps/build/include`.

Before you run the manual build you must run the `npm install` once to install the required dependencies, like `node-gyp` that are needed to compile `node-sodium`.
Please note that `npm install` will install the dependencies and compile `node-sodium` as well. After this initial step you can make changes to the source and run the following commands to manually build the module:

    make sodium
    
You need to install autotools and check the version. For OSX you can do

```
brew install libtool autoconf automake
```


```
autoconf --version
automake --version
libtool -V
```

# SECURITY WARNING: Using a Binary LibSodium Library

Node Sodium is a strong encryption library, odds are that a lot of security functions of your application depend on it, so *DO NOT* use binary libsodium distributions that you haven't verified.
If you use a pre-compiled version of libsodium you MUST be sure that nothing malicious was added to the compiled version you are using.

The Windows installation uses an official binary distribution that I maintain at [my repo](https://github.com/paixaop/libsodium-bin).
The files in this repository correspond to the files for the [MSVC libsodium build](http://www.libsodium.org/releases) version supported by node-sodium.
I will keep them updated as newer versions of libsodium become available and are supported by node-sodium.

These are provided in an attempt to simplify Windows installs and you should verify the file signatures against the originals, to make sure they haven't been
tampered with. They are provided AS IS and I take no responsibility for their correctness.

# Code Samples
Please check the fully documented code samples in `test/test_sodium.js`.

# Installing Mocha Test Suite

To run the unit tests you need Mocha. If you'd like to run coverage reports you need mocha-istanbul. You can install both globally by doing

    npm install -g mocha mocha-istanbul

You may need to run it with `sudo` as only the root user has access to Node.js global directories

    sudo npm install -g mocha mocha-istanbul

# Unit Tests
You need to have mocha test suite installed globally then you can run the node-sodium unit tests by

    make test

# Coverage Reports
You need to have mocha and mocha-istanbul installed globally then you can run the node-sodium coverage reports by

    make test-cov


# License
This software is licensed through the MIT License. Please read the LICENSE file for more details.

# Author

Built and maintained by Pedro Paixao
