/**
 * # Main module file
 * 
 * @module sodium
 * @name node-sodium
 * @author Pedro Paixao
 * @date 11/9/13
 *
 */
    
/* jslint node: true */
'use strict';


// Base
var binding = require('../build/Release/sodium');
var toBuffer = require('./toBuffer');

// Public Key
var Box = require('./box');
var Sign = require('./sign');

// Symmetric Key  
var SecretBox = require('./secretbox');
var Auth = require('./auth');
var OneTimeAuth = require('./onetime-auth');
var Stream = require('./stream');

// Elliptic Curve Diffie-Hellman using Curve25519
var ECDH = require('./ecdh');

// Nonces
var BoxNonce = require('./nonces/box-nonce');
var SecretBoxNonce = require('./nonces/secretbox-nonce');
var StreamNonce = require('./nonces/stream-nonce');

// Keys
var AuthKey = require('./keys/auth-key');
var BoxKey = require('./keys/box-key');
var OneTimeKey = require('./keys/onetime-key');
var SecretBoxKey = require('./keys/secretbox-key');
var SignKey = require('./keys/sign-key');
var StreamKey = require('./keys/stream-key');
var DHKey = require('./keys/dh-key');

/**
 * # API
 * Export all low level lib sodium functions directly
 * for developers that are used to lib sodium C interface
 */
module.exports.api = binding;

/** `libsodium` version */
module.exports.version = binding.version;
module.exports.versionMinor = binding.versionMinor;
module.exports.versionMajor = binding.versionMajor;

/** Utilities */
module.exports.Utils = {
    memzero:  binding.memzero,
    memcmp:   binding.memcmp,
    verify16: binding.crypto_verify_16,
    verify32: binding.crypto_verify_32,
    verify64: binding.crypto_verify_64,
    toBuffer: toBuffer,    
};

module.exports.Utils.to_hex = function (args) {
    var ret = "";
    for ( var i = 0; i < args.length; i++ )
        ret += (args[i] < 16 ? "0" : "") + args[i].toString(16);
    return ret; //.toUpperCase();
};

module.exports.Utils.from_hex = function (str) {
    if (typeof str == 'string') {
        var ret = new Uint8Array(Math.floor(str.length / 2));
        var i = 0;
        str.replace(/(..)/g, function(str) { ret[i++] = parseInt(str, 16);});
        return ret;
    }
};

/** Hash functions */
module.exports.Hash = {

    /** Default message hash */
    hash: binding.crypto_hash,

    /** SHA 256 */
    sha256: binding.crypto_hash_sha256,

    /** SHA 512 */
    sha512: binding.crypto_hash_sha512,
    
    /** Size of hash buffer in bytes */
    bytes: binding.crypto_hash_BYTES,
    
    /** Size of hash block */
    blockBytes: binding.crypto_hash_BLOCKBYTES,
    
    /** Default primitive */
    primitive: binding.crypto_hash_PRIMITIVE
};

/** Random Functions */
module.exports.Random = {

    /** Fill buffer with random bytest */
    buffer : binding.randombytes_buf,

    /** Initialize OS dependent random device */
    stir : binding.randombytes_stir,

    /** Close the random device */
    close : binding.randombytes_close,

    /** Return a random 32-bit unsigned value */
    rand : binding.randombytes_random,

    /** Return a value between 0 and upper_bound using a uniform distribution */
    uniform : binding.randombytes_uniform
};

// Public Key
module.exports.Box = Box;
module.exports.Sign = Sign;

// Symmetric Key
module.exports.Auth = Auth;
module.exports.SecretBox = SecretBox;
module.exports.Stream = Stream;
module.exports.OneTimeAuth = OneTimeAuth;

// Nonces
module.exports.Nonces = {
    Box: BoxNonce,
    SecretBox: SecretBoxNonce,
    Stream: StreamNonce
};

// Symmetric Keys
module.exports.Key = {
    SecretBox: SecretBoxKey,
    Auth: AuthKey,
    OneTimeAuth: OneTimeKey,
    Stream: StreamKey,

    // Public/Secret Key Pairs
    Box: BoxKey,
    Sign: SignKey,
    ECDH: DHKey
};

// Elliptic Curve Diffie-Hellman with Curve25519
module.exports.ECDH = ECDH;

/**
 * Lib Sodium Constants
 *
 * the base library defines several important constant that you should use to
 * check the size of buffers, nonces, keys, etc.
 *
 * All constants represent the size of the buffer or zone of a buffer in bytes
 */
module.exports.Const = {};

/** ScalarMult related constants */
module.exports.Const.ECDH = {
    /** Size of scalar buffers */
    scalarBytes: binding.crypto_scalarmult_SCALARBYTES,
    
    /** Size of scalar buffers */
    bytes: binding.crypto_scalarmult_BYTES,
    
    /** Size of the public and secret keys */
    keyBytes: binding.crypto_scalarmult_BYTES,
    
    /** String name of the default crypto primitive used in scalarmult operations */
    primitive: binding.crypto_scalarmult_PRIMITIVE
};

/** ScalarMult related constants */
module.exports.Const.ScalarMult = {
    /** Size of scalar buffers */
    scalarBytes: binding.crypto_scalarmult_SCALARBYTES,
    
    /** Size of the scalarmult keys and points */
    bytes: binding.crypto_scalarmult_BYTES,
    
    /** String name of the default crypto primitive used in scalarmult operations */
    primitive: binding.crypto_scalarmult_PRIMITIVE
};

/** Hash related constants */
module.exports.Const.Hash = {
    /** Size of hash buffer in bytes */
    bytes: binding.crypto_hash_BYTES,
    
    /** Size of hash block */
    blockBytes: binding.crypto_hash_BLOCKBYTES,
    
    /** Default primitive */
    primitive: binding.crypto_hash_PRIMITIVE
};

/** Box related constant sizes in bytes */
module.exports.Const.Box = {
    
    /** Box Nonce buffer size in bytes */
    nonceBytes : binding.crypto_box_NONCEBYTES,
    
    /** Box Public Key buffer size in bytes */
    publicKeyBytes : binding.crypto_box_PUBLICKEYBYTES,
    
    /** Box Public Key buffer size in bytes */
    secretKeyBytes : binding.crypto_box_SECRETKEYBYTES,
    
    /**
     * Messages passed to low level API should be padded with zeroBytes at the beginning.
     * This implementation automatically pads the message, so no need to do it on your own
     */
    zeroBytes : binding.crypto_box_ZEROBYTES,
    
    /**
     * Encrypted messages are padded with zeroBoxSize bytes of zeros. If the padding is not
     * there the message will not decrypt successfully.
     */
    boxZeroBytes : binding.crypto_box_BOXZEROBYTES,
    
    /**
     * Padding used in beforenm method. Like zeroBytes this implementation automatically
     * pads the message.
     *
     * @see Const.Box.zeroBytes
     */
    beforenmBytes : binding.crypto_box_BEFORENMBYTES,
    
    /** String name of the default crypto primitive used in box operations */
    primitive: binding.crypto_box_PRIMITIVE
};

/** Authentication Constants */
module.exports.Const.Auth = {
    
    /** Size of the authentication token */
    bytes: binding.crypto_auth_BYTES,

    /** Size of the secret key used to generate the authentication token */
    keyBytes: binding.crypto_auth_KEYBYTES,
    
    /** String name of the default crypto primitive used in auth operations */
    primitive: binding.crypto_auth_PRIMITIVE
};

/** One Time Authentication Constants */
module.exports.Const.OneTimeAuth = {

    /** Size of the authentication token */
    bytes: binding.crypto_onetimeauth_BYTES,
    
    /** Size of the secret key used to generate the authentication token */
    keyBytes: binding.crypto_onetimeauth_KEYBYTES,
    
    /** String name of the default crypto primitive used in onetimeauth operations */
    primitive: binding.crypto_onetimeauth_PRIMITIVE
};

/** SecretBox Symmetric Key Crypto Constants */
module.exports.Const.SecretBox = {

    /** SecretBox padding of cipher text buffer */
    boxZeroBytes: binding.crypto_secretbox_BOXZEROBYTES,
    
    /** Size of the secret key used to encrypt/decrypt messages */
    keyBytes: binding.crypto_secretbox_KEYBYTES,
    
    /** Size of the Nonce used in encryption/decryption of messages */
    nonceBytes: binding.crypto_secretbox_NONCEBYTES,
    
    /** Passing of message. This implementation does message padding automatically */
    zeroBytes: binding.crypto_secretbox_ZEROBYTES,
    
    /** String name of the default crypto primitive used in secretbox operations */
    primitive: binding.crypto_secretbox_PRIMITIVE
};

/** Digital message signature constants */
module.exports.Const.Sign = {

    /** Size of the generated message signature */
    bytes: binding.crypto_sign_BYTES,

    /** Size of the public key used to verify signatures */
    publicKeyBytes: binding.crypto_sign_PUBLICKEYBYTES,

    /** Size of the secret key used to sign a message */
    secretKeyBytes: binding.crypto_sign_SECRETKEYBYTES,
    
    /** String name of the default crypto primitive used in sign operations */
    primitive: binding.crypto_sign_PRIMITIVE
};

/** Symmetric Encryption Constants */
module.exports.Const.Stream = {
    /** Size of secret key used to encrypt/decrypt messages */
    keyBytes : binding.crypto_stream_KEYBYTES,

    /** Size of nonce used to encrypt/decrypt messages */
    nonceBytes : binding.crypto_stream_NONCEBYTES,
    
    /** String name of the default crypto primitive used in stream operations */
    primitive: binding.crypto_stream_PRIMITIVE
};

/** Short hash related constants */
module.exports.Const.ShortHash = {
    /** Size of short hash buffer in bytes*/
    bytes: binding.crypto_shorthash_BYTES,
    
    /** Size of short hash Key buffer in bytes */
    keyBytes: binding.crypto_shorthash_KEYBYTES,
    
    /** String name of primitive used to calculate short hash */
    primitive: binding.crypto_shorthash_PRIMITIVE
};

