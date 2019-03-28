#Low Level API
Parts of this document are copied from [NaCl library Documentation](http://nacl.cr.yp.to/index.html) by Daniel J. Bernstein, author of the great NaCl library which is the base of `libsodium`, and therefore `node-sodium`.

  * [Version Functions](#version-functions)
  * [Utility Functions](#utility-functions)
  * [Random Numbers](#random-numbers)
  * [Hash Functions](#hash-functions)
  * [Authentication Functions](#authentication-functions)
  * [Secret Key Encryption](#secret-key-encryption)
  * [Secret Key Authenticated Encryption](#secret-key-authenticated-encryption)
  * [Public Key Authenticated Encryption](#public-key-authenticated-encryption)
  * [Signatures](#signatures)
  * [Scalar Multiplication](#scalar-multiplication)

# API Usage
The low level `libsodium` API is available directly in `node-sodium` by using the `.api` object. Through it you can access all the functions [ported](./ported-functions.md) from `libsodium` without the use of the high level Javascript API. This will feel familiar for developers that are used to work with `libsodium` in other languages. It also gives you the chance to workaround any possible bugs on the higher level APIs.

If you're going to use the low level API you should do the following:

```javascript
var sodium = require('sodium').api;

// example of calling crypto_box_keypair
var version = sodium.sodium_version_string();

// getting a random number using libsodium PRNG
var num = sodium.randombytes_random();
```

The object `sodium` includes all the API calls. All code examples in this document assume that you have `var sodium = require('sodium').api;` somewhere in your code, before you call any API functions.

# Async Interface
At this time `node-sodium` only provides sync interface for low level API calls.

# Version Functions
Report the version of the Libsodium library

## sodium_version_string()

Get full version number of libsodium compiled with which node-sodium was compiled

**Returns**:

  * **{String}** with full lib sodium version. Example `0.4.5`
  
**Example**:
  
```javascript
var version = sodium.sodium_version_string();
console.log(version);  // output should be 0.4.5 or similar
```
  
## sodium_library_version_minor()
	
Get the minor version number of libsodium with which node-sodium was compiled. If the full version string is `0.4.5` this function will return `5`.

**Returns**:

  * **{Number}** of minor lib sodium version

**Example**:
  
```javascript
var minor_version = sodium.sodium_library_version_minor();
console.log(minor_version);  // output should be 5 or similar
```

  
## sodium_library_version_major()

Get the major version number of libsodium with which node-sodium was compiled. If the full version string is `0.4.5` this function will return `4`.

**Returns**:

  * **{Number}** of major lib sodium version
  
**Example**:
  
```javascript
var major_version = sodium.sodium_library_version_major();
if( major_version < 4) {
    console.log("Unsupported version");  // output should be 5 or similar
}
```
  
# Utility Functions

## memzero(buffer)

Securely wipe buffer

**Parameters**:

  * **{Buffer}** `buffer` to wipe

**Example**:
  
```javascript
// Lets create a new buffer with a string
var buffer = Buffer.from("I am a buffer", "utf-8");
console.log(buffer);            // <Buffer 49 20 61 6d 20 61 20 62 75 66 66 65 72>
console.log(buffer.toString()); // I'm a buffer! will be printed

// Now lets set all the bytes in the buffer to 0
sodium.memzero(buffer);
console.log(buffer);            // <Buffer 00 00 00 00 00 00 00 00 00 00 00 00 00>
```

## memcmp(buffer1, buffer2, size)

Compare buffers in constant time

**Parameters**:

  * **{Buffer}** `buffer1` you wish to compare with `buffer2`
  * **{Buffer}** `buffer2`
  * **{Number}** `size` number of bytes to compare
  
**Returns**:

  * `0` if `size` bytes of `buffer1` and `buffer2` are equal
  * another value if they are not

**Example**:

```
// Create the test buffers
var buffer1 = Buffer.from("I am a buffer", "utf-8");
var buffer2 = Buffer.from("I am a buffer too", "utf-8");

// Compare the two buffers for full length of the buffer1
if( sodium.memcmp(buffer1, buffer2, buffer1.length) == 0 ) {

	// This will print as the first 13 bytes of
	// buffer1 are equal to buffer2
	console.log("Buffers are equal")
}
```

## crypto_verify_16(buffer1, buffer2)

Compares the first 16 of the given buffers.

**Parameters**:

  * **{Buffer}** `buffer1` buffer you wish to compare with `buffer2`
  * **{Buffer}** `buffer2`
  
**Returns**:

  * `0` if first 16 bytes of `buffer1` and `buffer2` are equal
  * another value if they are not
  
This function is equivalent of calling `memcmp(buffer1, buffer2, 16)`

**Example**

```javascript
var b1= Buffer.from([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
var b2= Buffer.from([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 15, 16, 17, 18, 19, 20]);

if( sodium.crypto_verify_16(b1, b2) != 0 ) {
	console.log('buffers are different');
}
```

**See Also**:

  * [memcmp](#memcmpbuffer1-buffer2-size)
  * [crypto_verify_32](#crypto_verify_32buffer1-buffer2)
    

## crypto_verify_32(buffer1, buffer2)

Compares the first 32 of the given buffers.

**Parameters**:

  * **{Buffer}** `buffer1` you wish to compare with `buffer2`
  * **{Buffer}** `buffer2`
  
**Returns**:

  * `0` if first 32 bytes of `buffer1` and `buffer2` are equal
  * another value if they are not
  
This function is equivalent of calling `memcmp(buffer1, buffer2, 32)`

**See Also**:

  * [memcmp](#memcmpbuffer1-buffer2-size)
  * [crypto_verify_16](#crypto_verify_16buffer1-buffer2)
  
## sodium_bin2hex()
Use node's native `Buffer.toString()` method instead

  
# Random Numbers
Internal random number generator functions. Random numbers are a critical part of any encryption system. It is recommended that you use `libsodium` random number API, instead of the default javascript provided functions.

## randombytes(buffer)
Fill the specified buffer with size random bytes. Same as `randombytes_buf()`

**Parameters**:

  * **{Buffer}** `buffer` to fill with random data
  
**Example**:

```javascript
// Create a nonce
var b = Buffer.allocUnsafe(32);
sodium.randombytes(b,32);
```

**See Also**:
  * [randombytes_buf](#randombytes_bufbuffer)

## randombytes_buf(buffer)
Fill the specified buffer with size random bytes. Same as `randombytes()`

**Parameters**:

  * **{Buffer}** `buffer` to fill with random data
  
**Example**:

```javascript
// Create a nonce
var b = Buffer.allocUnsafe(32);
sodium.randombytes_buf(b,32);
```

**See Also**:
  * [randombytes](#randombytesbuffer)

  
## randombytes_close()
Close the file descriptor or the handle for the cryptographic service provider.

## randombytes_stir()
Generate a new key for the pseudorandom number generator.

## randombytes_random()
Generate a 32-bit unsigned random number

**Returns**:

  * **{Number}** random 32-bit unsigned value.

## randombytes_uniform(upperBound)
Generate a random number between `0` and `upperBound`

**Returns**:

  * **{Number}** between `0` and `upperBound` using a uniform distribution.

**Example**:

```javascript
var n = sodium.randombytes_uniform(100);
console.log(n);		// number between 0 and 100
```

# Hash Functions

## crypto_shorthash(buffer, secretKey)

A lot of applications and programming language implementations have been recently found to be vulnerable to denial-of-service attacks when a hash function with weak security guarantees, like Murmurhash 3, was used to construct a hash table.
In order to address this, Sodium provides the "shorthash" function, currently implemented using SipHash-2-4. This very fast hash function outputs short, but unpredictable (without knowing the secret key) values suitable for picking a list in a hash table for a given key.

**Parameters**:

  * **{Buffer}** `buffer` with the data you want to hash
  * **{Buffer}** `secretKey` the secret data used as key for the hash. `secretKey` **must** be `crypto_shorthash_KEYBYTES` in length.
 
**Returns**:

  * **{Buffer}** hashed message. Length of hash is always `sodium.crypto_shorthash_BYTES`

**Constants**:

  * `crypto_shorthash_BYTES` length of the hash
  * `crypto_shorthash_KEYBYTES` length of secret key
  * `crypto_shorthash_PRIMITIVE` name of hash function used

**Example**:

```javascript
var message = Buffer.from("Message to hash", "utf-8");
var key = Buffer.allocUnsafe(sodium.crypto_shorthash_KEYBYTES);

// generate a random key
sodium.crypto_randombytes_buf(key);

// calculate the hash
var hash = sodium.crypto_shorthash(message, key);
console.log(hash);
```

## crypto_hash(buffer)
Calculate a hash of a data buffer. You can check which of the supported hash functions is used by checking `crypto_hash_PRIMITIVE`. Currently the implementation of SHA-512 is used.

The `crypto_hash` function is designed to be usable as a strong component of DSA, RSA-PSS, key derivation, hash-based message-authentication codes, hash-based ciphers, and various other common applications. "Strong" means that the security of these applications, when instantiated with crypto_hash, is the same as the security of the applications against generic attacks. In particular, the crypto_hash function is designed to make finding collisions difficult.

**Parameters**:

  * **{Buffer}** `buffer` with the data you want to hash
 
**Returns**:

  * **{Buffer}** hashed message. Length of hash is always `sodium.crypto_hash_BYTES`

**Constants**:

  * `crypto_hash_BYTES` length of the hash
  * `crypto_hash_PRIMITIVE` name of hash function used

**Example**:

```javascript
var message = Buffer.from("Message to hash", "utf-8");

// calculate the hash
var hash = sodium.crypto_hash(message, key);
console.log(hash);
```
**See Also**:
 
  * [crypto_hash_sha256](#crypto_hash_sha256buffer)
  * [crypto_hash_sha512](#crypto_hash_sha512buffer)


## crypto_hash_sha256(buffer)
Calculate a SHA256 of a data buffer.

**Parameters**:

  * **{Buffer}** `buffer` with the data you want to hash
 
**Returns**:

  * **{Buffer}** hashed message
  
**Constants**:

  * `crypto_hash_sha256_BYTES` length of the hash

**Example**:

```javascript
var message = Buffer.from("Message to hash", "utf-8");

// calculate the hash
var hash = sodium.crypto_hash_sha256(message, key);
console.log(hash);
```

**See Also**:
 
  * [crypto_hash](#crypto_hashbuffer)
  * [crypto_hash_sha512](#crypto_hash_sha512buffer)


## crypto_hash_sha512(buffer)
Calculate a SHA256 of a data buffer.

**Parameters**:

  * **{Buffer}** `buffer` with the data you want to hash
 
**Returns**:

  * **{Buffer}** hashed message
  
**Constants**:

  * `crypto_hash_sha512_BYTES` length of the hash


**Example**:

```javascript
var message = Buffer.from("Message to hash", "utf-8");

// calculate the hash
var hash = sodium.crypto_hash_sha512(message, key);
console.log(hash);
```

**See Also**:
 
  * [crypto_hash](#crypto_hashbuffer)
  * [crypto_hash_sha256](#crypto_hash_sha512buffer)


# Authentication Functions


## crypto_auth(message, secretKey)
The `crypto_auth` function authenticates a `message` using a `secretKey`. The function returns an authenticator `token`. The authenticator length is always `crypto_auth_BYTES`.

As the name implies `secretKey` needs to be kept secret, between sender and receiver of the message. If `secretKey` is compromised an attacker can forge authentication tokens.

### Security Model

The `crypto_auth` function, viewed as a function of the message for a uniform random key, is designed to meet the standard notion of unforgeability. This means that an attacker cannot find authenticators for any messages not authenticated by the sender, even if the attacker has adaptively influenced the messages authenticated by the sender. For a formal definition see, e.g., Section 2.4 of Bellare, Kilian, and Rogaway, "The security of the cipher block chaining message authentication code," [Journal of Computer and System Sciences 61 (2000), 362–399;](http://www-cse.ucsd.edu/~mihir/papers/cbc.html).

NaCl/Libsodium does not make any promises regarding "strong" unforgeability; perhaps one valid authenticator can be converted into another valid authenticator for the same message. NaCl also does not make any promises regarding "truncated unforgeability."

**Parameters**:

  * **{Buffer}** `message` to authenticate
  * **{Buffer}** `secretKey` secret key used to authenticate the message and generate the authentication `token`. **Must** be `crypto_auth_KEYBYTES` in length

**Returns**

  * **{Buffer}** message authentication `token`

**Constants**:

  * `crypto_auth_KEYBYTES` length of secret key buffer
  * `crypto_auth_BYTES` length of authentication token buffer
  * `crypto_auth_PRIMITIVE` primitives used in message authentication and verification

  
**Example**:

```javascript
var message = Buffer.allocUnsafe(200);
var key = Buffer.allocUnsafe(sodium.crypto_auth_KEYBYTES);

// fill message with random data
sodium.randombytes(message);

// generate a random secret key
sodium.crypto_randombytes(key);

var token = sodium.crypto_auth(message, key);
var r = sodium.crypto_auth_verify(token, message, key);
if( r != 0) {
	console.log("message authentication failed");
}
else {
	console.log("message authenticated");
}
```

**See Also**:

  * [crypto_auth_verify](#crypto_auth_verifytoken-message-secretkey)
  

## crypto_auth_verify(token, message, secretKey)
The `crypto_auth_verify` function verifies if the `token` is a correct authenticator generated by `crypto_auth` for `message` under `secretKey`.

**Parameters**:

  * **{Buffer}** `token` message authenticator. **Must** be `crypto_auth_BYTES` in length
  * **{Buffer}** `message` to authenticate
  * **{Buffer}** `secretKey` same secret key used in the `crypto_auth` call. **Must** be `crypto_auth_KEYBYTES` in length

**Returns**

  * `0` if `token` is a correct authenticator of `message` under `secretKey`
  * `-1` otherwise

**Constants**:

  * `crypto_auth_KEYBYTES` length of secret key buffer
  * `crypto_auth_BYTES` length of authentication token buffer
  * `crypto_auth_PRIMITIVE` primitives used in message authentication and verification
  
**See Also**:

  * [crypto_auth](#crypto_authmessage-secretkey)
  

## crypto_onetimeauth(message, secretKey)
The `crypto_onetimeauth` function authenticates a `message` using a `secretKey`. The function returns an authenticator `token`. The authenticator length is always `crypto_onetimeauth_BYTES`.

As the name implies `secretKey` needs to be kept secret, between sender and receiver of the message. If `secretKey` is compromised an attacker can forge authentication tokens.

### Security Model

The `crypto_onetimeauth` function, viewed as a function of the message for a uniform random key, is designed to meet the standard notion of unforgeability after a single message. After the sender authenticates one message, an attacker cannot find authenticators for any other messages.
The sender must not use `crypto_onetimeauth` to authenticate more than **one** message under the same key. Authenticators for two messages under the same key should be expected to reveal enough information to allow forgeries of authenticators on other messages.

In situations where multiple messages need to be authenticated use [`crypto_auth`](#crypto_authmessage-secretkey).

**Parameters**:

  * **{Buffer}** `message` to authenticate
  * **{Buffer}** `secretKey` secret key used to authenticate the message and generate the authentication `token`. **Must** be `crypto_onetimeauth_KEYBYTES` in length

**Returns**

  * **{Buffer}** message authentication `token`

**Constants**:

  * `crypto_onetimeauth_KEYBYTES` length of secret key buffer
  * `crypto_onetimeauth_BYTES` length of authentication token buffer
  * `crypto_onetimeauth_PRIMITIVE` primitives used in message authentication and verification

  
**Example**:

```javascript
var message = Buffer.allocUnsafe(200);
var key = Buffer.allocUnsafe(sodium.crypto_auth_KEYBYTES);

// fill message with random data
sodium.randombytes(message);

// generate a random secret key
sodium.randombytes(key);

var token = sodium.crypto_onetimeauth(message, key);
var r = sodium.crypto_onetimeauth_verify(token, message, key);
if( r != 0) {
	console.log("message authentication failed");
}
else {
	console.log("message authenticated");
}
```

**See Also**:

  * [crypto_onetimeauth_verify](#crypto_onetimeauth_verifytoken-message-secretkey)
  

## crypto_onetimeauth_verify(token, message, secretKey)
The `crypto_onetimeauth_verify` function verifies if the `token` is a correct authenticator generated by `crypto_auth` for `message` under `secretKey`.

**Parameters**:

  * **{Buffer}** `token` message authenticator. **Must** be `crypto_onetimeauth_BYTES` in length
  * **{Buffer}** `message` to authenticate
  * **{Buffer}** `secretKey` same secret key used in the `crypto_auth` call. **Must** be `crypto_onetimeauth_KEYBYTES` in length

**Returns**

  * `0` if `token` is a correct authenticator of `message` under `secretKey`
  * `-1` otherwise

**Constants**:

  * `crypto_onetimeauth_KEYBYTES` length of secret key buffer
  * `crypto_onetimeauth_BYTES` length of authentication token buffer
  * `crypto_onetimeauth_PRIMITIVE` primitives used in message authentication and verification
  
**See Also**:

  * [crypto_onetimeauth](#crypto_onetimeauthmessage-secretkey)
  

# Secret Key Encryption
As the name implies "Secret Key Encryption" requires that keys are kept secret, and users need to find a secure way to exchange secret keys so they are not compromised.

## crypto_stream(length, nonce, secretKey)

Generates a stream (Buffer) of `length` bytes using the given `secretKey` and `nonce`.

**Parameters**:

   * **{Buffer}** `nonce` used to generate the stream. **Must** be `crypto_stream_NONCEBYTES` in length
   * **{Buffer}** `secretKey` the key used to generate the stream. **Must** be `crypto_stream_KEYBYTES` in length
   
**Returns**:
 
  * **{Buffer}** that is a function of `secretKey` and `nonce`
  * `undefined` if an error occured

**Constants**:

  * `crypto_stream_KEYBYTES` length of secret key buffer
  * `crypto_stream_NONCEBYTES` length of nonce buffer
  * `crypto_stream_PRIMITIVE` primitive used in the stream generation

**Example**:

```javascript
var key = Buffer.allocUnsafe(sodium.crypto_stream_KEYBYTES);
var nonce = Buffer.allocUnsafe(sodium.crypto_stream_NONCEBYTES);

// Generate random key and nonce
sodium.randombytes(key);
sodium.randombytes(nonce);

var r = sodium.crypto_stream(1000,nonce,key);
if( !r ) {
    throw('bad stream');
}
```

## crypto_stream_xor(message, nonce, secretKey)

The `crypto_stream_xor` function encrypts, or decrypts, a `message` using a `secretKey` and `nonce`.

The `crypto_stream_xor` function guarantees that the cipher text has the same length as the plaintext, and is the plaintext xor the output of `crypto_stream`. Consequently crypto_stream_xor can also be used to decrypt.

**Parameters**:

   * **{Buffer}** `message` the message to encrypt/decrypt
   * **{Buffer}** `nonce` used to generate the stream. **Must** be `crypto_stream_NONCEBYTES` in length
   * **{Buffer}** `secretKey` the key used to generate the stream. **Must** be `crypto_stream_KEYBYTES` in length
   
**Returns**:
 
  * **{Buffer}** that is a function of `secretKey` and `nonce`
  * `undefined` if an error occured

**Constants**:

  * `crypto_stream_KEYBYTES` length of secret key buffer
  * `crypto_stream_NONCEBYTES` length of nonce buffer
  * `crypto_stream_PRIMITIVE` primitive used in the stream generation

**Example**:

```javascript
var plainMsg = Buffer.from("This is my plain text","utf-8");
var key = Buffer.allocUnsafe(sodium.crypto_stream_KEYBYTES);
var nonce = Buffer.allocUnsafe(sodium.crypto_stream_NONCEBYTES);

// generate a random key and nonce
sodium.randombytes(key);
sodium.randombytes(nonce);

// Encrypt the message
var cipherMsg = sodium.crypto_stream_xor(plainMsg,nonce,key);
if( !cipherMsg ) {
    throw("error");
}
console.log(cipherMsg);

// Decrypt the message
var plainMsg2 = sodium.crypto_stream_xor(cipherMsg,nonce,key);
if( !plainMsg2 ) {
    throw("error");
}
console.log(plainMsg2.toString());
```

# Secret key Authenticated Encryption

## Constants

 * `crypto_secretbox_KEYBYTES` size of shared secret key
 * `crypto_secretbox_NONCEBYTES` size of Nonce
 * `crypto_secretbox_BOXZEROBYTES` number of leading 0 bytes in the cipher-text
 * `crypto_secretbox_ZEROBYTES` number of leading 0 bytes in the message
 * `crypto_secretbox_PRIMITIVE` primitives used to encrypt and authenticate `message`

## crypto_secretbox(message, nonce, secretKey)

Encrypts and authenticates a `message` using a unique `nonce` and a `secretKey`.

### Security Model

The `crypto_secretbox` function is designed to meet the standard notions of privacy and authenticity for a secret-key authenticated-encryption scheme using nonces. For formal definitions see, e.g., Bellare and Namprempre, "Authenticated encryption: relations among notions and analysis of the generic composition paradigm, [Lecture Notes in Computer Science 1976 (2000), 531–545](http://www-cse.ucsd.edu/~mihir/papers/oem.html).

Note that the length is not hidden. Note also that it is the caller's responsibility to ensure the uniqueness of nonces—for example, by using nonce 1 for the first message, nonce 2 for the second message, etc. Nonces are long enough that randomly generated nonces have negligible risk of collision.

Unlike the original `libsodium` `crypto_secretbox` automatically pads the `message` with `crypto_secretbox_ZEROBYTES`, so do not pad the `message` yourself.

**Parameters**:

  * **{Buffer}** `message` message to encrypt
  * **{Buffer}** `nonce` unique number. **Must** be `crypto_secretbox_NONCEBYTES` in length
  * **{Buffer}** `secretKey` with shared secret key. **Must** be `crypto_secretbox_KEYBYTES` in length

**Returns**:

  * **{Buffer}**  with encrypted message
  * `undefined` in case of error

**Example**:

```javascript
var plainMsg = Buffer.from("This is my plain text","utf-8");

// generate random key and nonce
var key = Buffer.allocUnsafe(sodium.crypto_secretbox_KEYBYTES);
var nonce = Buffer.allocUnsafe(sodium.crypto_secretbox_NONCEBYTES);
sodium.randombytes(key);
sodium.randombytes(nonce);

// Encrypt and authenticate the message
var cipherMsg = sodium.crypto_secretbox(plainMsg,nonce,key);
if( !cipherMsg ) {
    throw("error");
}
console.log(cipherMsg);

// Decrypt the message
var plainMsg2 = sodium.crypto_secretbox_open(cipherMsg,nonce,key);
if( !plainMsg2 ) {
    throw("error");
}
console.log(plainMsg2.toString());
```

**See Also**:

  * [crypto_secretbox_open](#crypto_secretbox_openciphertext-nonce-key)
  * [crypto_stream_xor](#crypto_stream_xormessage-nonce-secretkey)

## crypto_secretbox_open(cipherText, nonce, key)

Verifies and decrypts a `cipherText` using a unique `nonce` and a `secretKey`

**Parameters**:

  * **{Buffer}** `cipherText` message to decrypt
  * **{Buffer}** `nonce` unique number. **Must** be `crypto_secretbox_NONCEBYTES` in length
  * **{Buffer}** `secretKey` with shared secret key. **Must** be `crypto_secretbox_KEYBYTES` in length
  
**Returns**:

  * **{Buffer}**  with decrypted message
  * `undefined` in case of error
 
**See Also**:
 
  * [crypto_secretbox](#crypto_secretboxmessage-nonce-secretkey)
  * [crypto_stream_xor](#crypto_stream_xormessage-nonce-secretkey)

# Public Key Authenticated Encryption

## Detailed Description

Definitions and functions to perform Authenticated Encryption.

Authentication encryption provides guarantees towards the:

  * confidentiality
  * integrity
  * authenticity of data.

Alongside the standard interface there also exists a pre-computation interface. In the event that applications are required to send several messages to the same receiver, speed can be gained by splitting the operation into two steps: before and after. Similarly applications that receive several messages from the same sender can gain speed through the use of the: `before`, and `open_after` functions.

## Constants

  * `crypto_box_PUBLICKEYBYTES` Size of Public Key
  * `crypto_box_SECRETKEYBYTES` Size of Secret Key
  * `crypto_box_BEFORENMBYTES`  Size of pre-computed cipher text
  * `crypto_box_NONCEBYTES`     Size of Nonce
  * `crypto_box_ZEROBYTES`      No. of leading 0 bytes in the message
  * `crypto_box_BOXZEROBYTES`   No. of leading 0 bytes in the cipher-text
  

## crypto_box_keypair()

Generates a random secret key and a corresponding public key.

**Returns**:

  * **{Object}** `keypair` with public and secret keys

        { secretKey: <secret key buffer>,
          publicKey: <public key buffer> }

  * `undefined` in case or error
  
**Key lengths**:

  * `secretKey` is `crypto_box_SECRETKEYBYTES` bytes in length
  * `publicKey` is `crypto_box_PUBLICKEYBYTES` bytes in length
  
**Example**:

```javascript
var bobKeys = sodium.crypto_box_keypair();
```

## crypto_box(message, nonce, pk, sk)

Encrypts a message given the senders secret key, and receivers public key.

### Security Model

The `crypto_box` function is designed to meet the standard notions of privacy and third-party unforgeability for a public-key authenticated-encryption scheme using nonces. For formal definitions see, e.g., Jee Hea An, ["Authenticated encryption in the public-key setting: security notions and analyses,"](http://eprint.iacr.org/2001/079).

Distinct messages between the same {sender, receiver} set are required to have distinct nonces. For example, the lexicographically smaller public key can use nonce 1 for its first message to the other key, nonce 3 for its second message, nonce 5 for its third message, etc., while the lexicographically larger public key uses nonce 2 for its first message to the other key, nonce 4 for its second message, nonce 6 for its third message, etc. Nonces are long enough that randomly generated nonces have negligible risk of collision.

There is no harm in having the same nonce for different messages if the {sender, receiver} sets are different. This is true even if the sets overlap. For example, a sender can use the same nonce for two different messages if the messages are sent to two different public keys.

The `crypto_box` function is not meant to provide non-repudiation. On the contrary: the `crypto_box` function guarantees repudiability. A receiver can freely modify a boxed message, and therefore cannot convince third parties that this particular message came from the sender. The sender and receiver are nevertheless protected against forgeries by other parties. In the terminology of http://groups.google.com/group/sci.crypt/msg/ec5c18b23b11d82c, `crypto_box` uses "public-key authenticators" rather than "public-key signatures."

Users who want public verifiability (or receiver-assisted public verifiability) should instead use signatures (or signcryption).

**Parameters**:

  * **{Buffer}** `message` to encrypt
  * **{Buffer}** `nonce` for crypto box. **Must** be `crypto_box_NONCEBYTES` in length
  * **{Buffer}** `pk` recipient's public key. **Must** be `crypto_box_PUBLICKEYBYTES` in length
  * **{Buffer}** `sk` sender's secret key. **Must** be `crypto_box_SECRETKEYBYTES` in length

**Returns**:

  * **{Buffer}** with encrypted message
  * `undefined` in case or error
  
**Example**:

```javascript
var plainMsg = Buffer.from("This is my plain text","utf-8");

// Generate new random public and secret keys for Bob and Alice
var bobKeys = sodium.crypto_box_keypair();
var aliceKeys = sodium.crypto_box_keypair();

// Generate a new nonce
var nonce = Buffer.allocUnsafe(sodium.crypto_box_NONCEBYTES);
sodium.randombytes(nonce);

// Bob wants to send an encrypted message to Alice
var cipherMsg = sodium.crypto_box(plainMsg,nonce,aliceKeys.publicKey, bobKeys.secretKey);
if( !cipherMsg ) {
    throw("error");
}
console.log(cipherMsg);

// Alice wants to decrypt Bob's message
var plainMsg2 = sodium.crypto_box_open(cipherMsg,nonce, bobKeys.publicKey, aliceKeys.secretKey);
if( !plainMsg2 ) {
    throw("error");
}
console.log(plainMsg2.toString());

console.log(sodium.crypto_box_PRIMITIVE);
```

**See Also**:

  * [crypto_box_beforenm](#crypto_box_beforenmpk-sk)
  * [crypto_box_afternm](#crypto_box_afternmmessage-nonce-k)
  * [crypto_box_open_afternm](#crypto_box_open_afternmmessage-nonce-k)
  * [crypto_box_open](#crypto_box_openctxt-nonce-pk-sk)


## crypto_box_open(ctxt, nonce, pk, sk)

Decrypts a cipher text ctxt given the receivers private key, and senders public key and the same nonce that was used when calling `crypto_box`.

**Parameters**:

  * **{Buffer}** `ctxt` with cipher text
  * **{Buffer}** `nonce` for crypto box. **Must** be `crypto_box_NONCEBYTES` in length
  * **{Buffer}** `pk` recipient's public key. **Must** be `crypto_box_PUBLICKEYBYTES` in length
  * **{Buffer}** `sk` sender's secret key. **Must** be `crypto_box_SECRETKEYBYTES` in length
  
**Returns**:

  * **{Buffer}** with plain text
  * `undefined` in case or error

**Example**:

```javascript
var plainMsg = Buffer.from("This is my plain text","utf-8");

// Generate new random public and secret keys for Bob and Alice
var bobKeys = sodium.crypto_box_keypair();
var aliceKeys = sodium.crypto_box_keypair();

// Generate a new nonce
var nonce = Buffer.allocUnsafe(sodium.crypto_box_NONCEBYTES);
sodium.randombytes(nonce);

// Bob wants to send an encrypted message to Alice
var cipherMsg = sodium.crypto_box(plainMsg,nonce,aliceKeys.publicKey, bobKeys.secretKey);
if( !cipherMsg ) {
    throw("error");
}
console.log(cipherMsg);

// Alice wants to decrypt Bob's message
var plainMsg2 = sodium.crypto_box_open(cipherMsg,nonce, bobKeys.publicKey, aliceKeys.secretKey);
if( !plainMsg2 ) {
    throw("error");
}
console.log(plainMsg2.toString());

console.log(sodium.crypto_box_PRIMITIVE);
```

**See Also**:

  * [crypto_box_beforenm](#crypto_box_beforenmpk-sk)
  * [crypto_box_afternm](#crypto_box_afternmmessage-nonce-k)
  * [crypto_box_open_afternm](#crypto_box_open_afternmmessage-nonce-k)
  * [crypto_box](#crypto_boxmessage-nonce-pk-sk)

## crypto_box_beforenm(pk, sk)

Partially performs the computation required for both encryption and decryption of data. Use this function to speed up your encryption/decryption if you are going to send many messages between any pair of senders and receivers.

**Parameters**:

 * **{Buffer}** `pk` recipient's public key. **Must** be `crypto_box_PUBLICKEYBYTES` in length
 * **{Buffer}** `sk` sender's secret key. **Must** be `crypto_box_SECRETKEYBYTES` in length
  
**Returns**:

  * **{Buffer}** `k` the pre-computation result to be used in the `afternm` function calls
  * `undefined` in case of error.
  
**Example**:

```javascript
var plainMsgs = new Array(3);
plainMsgs[0] = Buffer.from("This is my plain text 1","utf-8");
plainMsgs[1] = Buffer.from("This is my plain text 2","utf-8");
plainMsgs[2] = Buffer.from("This is my plain text 3","utf-8");

// Generate new random public and secret keys for Bob and Alice
var bobKeys = sodium.crypto_box_keypair();
var aliceKeys = sodium.crypto_box_keypair();

// Generate a new nonce
var nonce = Buffer.allocUnsafe(sodium.crypto_box_NONCEBYTES);
sodium.randombytes(nonce);

// Bob's side
// Bob wants to send several messages to Alice, so he precomputes the first
// step of the encryption using Alice's public key and his own secret key
var bobPreCompK = sodium.crypto_box_beforenm(aliceKeys.publicKey, bobKeys.secretKey);

var cipherMsgs = new Array(3);
for (var i=0; i < plainMsgs.length; i++) {
	cipherMsgs[i] = sodium.crypto_box_afternm(plainMsgs[i],nonce, bobPreCompK);
	if( !cipherMsgs[i] ) {
		throw("error");
	}
}

// Alice's Side
// Alice wants to decrypt several messages from Bob, so she precomputes the first
// step using Bob's public key and her own secret key
var alicePreCompK = sodium.crypto_box_beforenm(bobKeys.publicKey, aliceKeys.secretKey);

var plainMsgs2 = new Array(3);
for (var i=0; i < cipherMsgs.length; i++) {
	plainMsgs2[i] = sodium.crypto_box_open_afternm(cipherMsgs[i], nonce, alicePreCompK);
	if( !cipherMsgs[i] ) {
		throw("error");
	}
	console.log(plainMsgs2[i].toString());
}
```

**See Also**:

  * [crypto_box_afternm](#crypto_box_afternmmessage-nonce-k)
  * [crypto_box_open_afternm](#crypto_box_open_afternmmessage-nonce-k)
  * [crypto_box_open](#crypto_box_openctxt-nonce-pk-sk)
  * [crypto_box](#crypto_boxmessage-nonce-pk-sk)

## crypto_box_afternm(message, nonce, k)

Encrypts a given a `message`, using partial computed data `k`.

**Parameters**:

  * **{Buffer}** `message` to encrypt
  * **{Buffer}** `nonce` for crypto box. **Must** be `crypto_box_NONCEBYTES` in length
  * **{Buffer}** `k` buffer calculated by the [`crypto_box_beforenm`](#crypto_box_beforenmpk-sk) function call

**Returns**:

  * **{Buffer}** with the cipher text
  * `undefined` in case or error
  
**See Also**:

  * [crypto_box_beforenm](#crypto_box_beforenmpk-sk)
  * [crypto_box_open_afternm](#crypto_box_open_afternmmessage-nonce-k)
  * [crypto_box_open](#crypto_box_openctxt-nonce-pk-sk)
  * [crypto_box](#crypto_boxmessage-nonce-pk-sk)

## crypto_box_open_afternm(ctxt, nonce, k)

Decrypts a cipher text `ctxt` given the receivers given a `nonce` and the partial computed data `k`.

**Parameters**:

  * **{Buffer}** `ctxt` message to decrypt
  * **{Buffer}** `nonce` for crypto box. **Must** be `crypto_box_NONCEBYTES` in length
  * **{Buffer}** `k` buffer calculated by the [`crypto_box_beforenm`](#crypto_box_beforenmpk-sk) function call
 
**Returns**:

  * **{Buffer}** with the plain text
  * `undefined` in case or error
  
**See Also**:

  * [crypto_box_beforenm](#crypto_box_beforenmpk-sk)
  * [crypto_box_afternm](#crypto_box_afternmmessage-nonce-k)
  * [crypto_box_open](#crypto_box_openctxt-nonce-pk-sk)
  * [crypto_box](#crypto_boxmessage-nonce-pk-sk)

# Signatures

## Constants

  * `crypto_sign_BYTES` length of resulting signature.
  * `crypto_sign_PUBLICKEYBYTES` length of verification key.
  * `crypto_sign_SECRETKEYBYTES` length of signing key.


## crypto_sign_keypair()

Generates a random signing key pair with a secret key and corresponding public key. Returns an object with two buffers as follows:

**Returns**:

  * **{Object}** `keypair` with public and secret keys

        { secretKey: <secret key buffer>,
          publicKey: <public key buffer> }

  * `undefined` in case or error
  
**Key lengths**:

  * `secretKey` is `crypto_sign_SECRETKEYBYTES` bytes in length
  * `publicKey` is `crypto_sign_PUBLICKEYBYTES` bytes in length
  
**Example**:

```javascript
var bobKeys = sodium.crypto_sign_keypair();
```

## crypto_sign_seed_keypair(seed)

Deterministically generates a signing key pair with a secret key and
corresponding public key. The signing key pair is used for signing and contains
the seed, in fact the only secret is the seed the other parts of the signing key
always be reconstructed from the seed using this method. Hence, you only have
to save the seed in your configuration file, database or where you store keys.

**Parameters**:

  * **Buffer** `message` to sign
  * **Buffer** `seed` to generate signing key pair from. **Must** be `crypto_sign_SEEDBYTES` in length

**Returns**:

  * **{Object}** `keypair` with public and secret keys

        { secretKey: <secret key buffer>,
          publicKey: <public key buffer> }

  * `undefined` in case or error

**Key lengths**:

  * `secretKey` is `crypto_sign_SECRETKEYBYTES` bytes in length
  * `publicKey` is `crypto_sign_PUBLICKEYBYTES` bytes in length

**Example**:

```javascript
var seed = new buffer('zSX0jgvyyaw8n+Z/Iv6lS7EI9pS7aesQUgxIsihjXfA=', 'base64');
var aliceKeys = sodium.crypto_sign_seed_keypair(seed);
```

     
## crypto_sign(message, secretKey)
The `crypto_sign` function is designed to meet the standard notion of unforgeability for a public-key signature scheme under chosen-message attacks.

Signs `message` using the signer's signing secret key

**Parameters**:

  * **Buffer** `message` to sign
  * **Buffer** `secretKey` signer's secret key. **Must** be `crypto_sign_SECRETKEYBYTES` in length
  
**Returns**:

  * **Buffer** with signed message
  * `undefined` in case or error
  
**Example**:

```javascript
var keys = sodium.crypto_sign_keypair();
var message = Buffer.from("node-sodium is cool", 'utf8');
var signedMsg = sodium.crypto_sign(message, keys.secretKey);
if( sodium.crypto_sign_open(signedMsg, keys.publicKey) ) {
	console.log("signature is valid");
}
```

        
## crypto_sign_open(signedMsg, publicKey)

Verifies the signed message `signedMsg` using the signer's verification key, or `publicKey`.

**Parameters**:

  * **Buffer** `signedMsg` signed message
  * **Buffer** `publicKey` signer's public key. **Must** be `crypto_sign_PUBLICKEYBYTES` in length
  
**Returns**:

  * **Buffer** with original message
  * `undefined` if verification fails.

**Example**:

```javascript
var keys = sodium.crypto_sign_keypair();
var message = Buffer.from("node-sodium is cool", 'utf8');
var signedMsg = sodium.crypto_sign(message, keys.secretKey);
if( sodium.crypto_sign_open(signedMsg, keys.publicKey) ) {
	console.log("signature is valid");
}
```


# Scalar Multiplication

## Constants
  * `crypto_scalarmult_SCALARBYTES` size of integer
  * `crypto_scalarmult_BYTES` size of group element
  * `crypto_scalarmult_PRIMITIVE` name of primitive used by default
    
## crypto_scalarmult(n, p)
The `crypto_scalarmult` multiplies a group element `p` by an integer `n`.

### Security Model

`crypto_scalarmult` is designed to be strong as a component of various well-known "hashed Diffie–Hellman" applications. In particular, it is designed to make the "computational Diffie–Hellman" problem (CDH) difficult with respect to the standard base.

`crypto_scalarmult` is also designed to make CDH difficult with respect to other nontrivial bases. In particular, if a represented group element has small order, then it is annihilated by all represented scalars. This feature allows protocols to avoid validating membership in the subgroup generated by the standard base.

NaCl/Libsodium does not make any promises regarding the "decisional Diffie–Hellman" problem (DDH), the "static Diffie–Hellman" problem (SDH), etc. Users are responsible for hashing group elements.

### Selected Primitive

`crypto_scalarmult` is the function `crypto_scalarmult_curve25519` specified in "Cryptography in NaCl", Sections 2, 3, and 4. This function is conjectured to be strong. For background see Bernstein, "Curve25519: new Diffie-Hellman speed records,["Lecture Notes in Computer Science 3958" (2006), 207–228](http://cr.yp.to/papers.html#curve25519).

**Parameters**:

  * **Buffer** `n` integer to multiply by base. **Must** be `crypto_scalarmult_SCALARBYTES` in length
  * **Buffer** `p` group element. **Must** be `crypto_scalarmult_BYTES` in length

**Returns**:

  * **Buffer** with multiplication result
  * `undefined` if an error occurs.
  
**Example**:

```javascript
// Generate a random group element and integer
var p = Buffer.allocUnsafe(sodium.crypto_scalarmult_BYTES);
var n = Buffer.allocUnsafe(sodium.crypto_scalarmult_SCALARBYTES);
sodium.randombytes(p);
sodium.randombytes(n);

// Multiply them
var r = sodium.crypto_scalarmult(n,p);
console.log(r);
```


## crypto_scalarmult_base(n)
The `crypto_scalarmult_base` function computes the scalar product of a standard group element and an integer `n`

**Parameters**:

  * **Buffer** `n` integer to multiply by base. **Must** be `crypto_scalarmult_SCALARBYTES` in length

**Returns**:

  * **Buffer** with multiplication result
  * `undefined` if an error occurs.

**Example**:

```javascript
// Generate a random integer
var n = Buffer.allocUnsafe(sodium.crypto_scalarmult_SCALARBYTES);
sodium.randombytes(n);

// Multiply them
var r = sodium.crypto_scalarmult_base(n);
console.log(r);
```
