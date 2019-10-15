/**
 * Created by bmf on 11/2/13.
 *
 * Documentation of crypto http://nacl.cr.yp.to/box.html
 */
 /* jslint node: true */
'use strict';

var binding = require('../build/Release/sodium');
var assert = require('assert');
var toBuffer = require('./toBuffer');
var SecretBoxKey = require('./keys/secretbox-key');
var Nonce = require('./nonces/secretbox-nonce');

/**
 * Public-key authenticated encryption: Box
 *
 * @param {String|Buffer|Array} secretKey sender's private key.
 * @param {String|Buffer|Array} publicKey recipient's private key.
 *
 * @see Keys
 * @constructor
 */
module.exports  = function SecretBox(secretKey, encoding) {
    var self = this;

    /** default encoding to use in all string operations */
    self.defaultEncoding = undefined;

    if( secretKey instanceof SecretBoxKey) {
        self.boxKey = secretKey;
    }
    else {
        /** Set the keys used to encrypt and decrypt messages */
        self.boxKey = new SecretBoxKey(secretKey, encoding);
    }

    /** SecretBox padding of cipher text buffer */
    self.boxZeroBytes = function() {
        return binding.crypto_secretbox_BOXZEROBYTES;
    };

    /** Passing of message. This implementation does message padding automatically */
    self.zeroBytes = function() {
        return binding.crypto_secretbox_ZEROBYTES;
    };

    /** String name of the default crypto primitive used in secretbox operations */
    self.primitive = function() {
        return binding.crypto_secretbox_PRIMITIVE;
    };

    /**
     * Get the box-key secret key object
     * @returns {BoxKey|*}
     */
    self.key = function() {
        return self.boxKey;
    };

    /**
     * Set the default encoding to use in all string conversions
     * @param {String} encoding  encoding to use
     */
    self.setEncoding = function(encoding) {
        assert(!!encoding.match(/^(?:utf8|ascii|binary|hex|utf16le|ucs2|base64)$/), 'Encoding ' + encoding + ' is currently unsupported.');
        self.defaultEncoding = encoding;
    };

    /**
     * Get the current default encoding
     * @returns {undefined|String}
     */
    self.getEncoding = function() {
        return self.defaultEncoding;
    };

    /**
     * Encrypt a message
     * The crypto_secretbox function is designed to meet the standard notions of
     * privacy and authenticity for a secret-key authenticated-encryption scheme
     * using nonces. For formal definitions see, e.g., Bellare and Namprempre,
     * "Authenticated encryption: relations among notions and analysis of the
     * generic composition paradigm," Lecture Notes in Computer Science
     * 1976 (2000), 531–545, http://www-cse.ucsd.edu/~mihir/papers/oem.html.
     *
     * Note that the length is not hidden. The basic API leaves it up to the
     * caller to generate a unique nonce for every message, in the high level
     * API a random nonce is generated automatically and you do no need to
     * worry about it.
     *
     * If no options are given a new random nonce will be generated automatically
     * and both planText and cipherText must be buffers
     *
     * @param {Buffer|String|Array} plainText  message to encrypt
     * @param {String} [encoding]             encoding of message string
     *
     * @returns {Object}                       cipher box
     */
    self.encrypt = function (plainText, encoding) {
        encoding = encoding || self.defaultEncoding;

        // generate a new random nonce
        var nonce = new Nonce();

        var buf = toBuffer(plainText, encoding);

        var cipherText = binding.crypto_secretbox(
            buf,
            nonce.get(),
            self.boxKey.get());

        if( !cipherText ) {
            return undefined;
        }

        return {
            cipherText: cipherText,
            nonce : nonce.get()
        };
    };

    /**
     * The decrypt function verifies and decrypts a cipherText using the
     * receiver's secret key, the sender's public key, and a nonce.
     * The function returns the resulting plaintext m.
     *
     * @param {Buffer|String|Array} cipherText  the encrypted message
     * @param {Buffer|String|Array} nonce       the nonce used to encrypt
     * @param {String} [encoding]               the encoding to used in cipherText, nonce, plainText
     */
    self.decrypt = function (cipherBox, encoding) {
        encoding = String(encoding || self.defaultEncoding);

        assert(typeof cipherBox == 'object' && cipherBox.hasOwnProperty('cipherText') && cipherBox.hasOwnProperty('nonce'), 'cipherBox is an object with properties `cipherText` and `nonce`.');
        assert(cipherBox.cipherText instanceof Buffer, 'cipherBox should have a cipherText property that is a buffer') ;
        assert(cipherBox.nonce instanceof Buffer, 'cipherBox should have a nonce property that is a buffer') ;

        var nonce = new Nonce(cipherBox.nonce);

        var plainText = binding.crypto_secretbox_open(
            cipherBox.cipherText,
            nonce.get(),
            self.boxKey.get()
        );

        if( plainText && encoding ) {
            return plainText.toString(encoding);
        }

        return plainText;
    };

    // Aliases
    self.close = self.encrypt;
    self.open = self.decrypt;
};
