/**
 * Created by bmf on 11/2/13.
 *
 * Documentation of crypto http://nacl.cr.yp.to/box.html
 */
 /* jslint node: true */
'use strict';

var binding = require('../build/Release/sodium');
var toBuffer = require('./toBuffer');
var BoxKey = require('./keys/box-key');
var Nonce = require('./nonces/box-nonce');
var assert = require('assert');

/**
 * Public-key authenticated encryption: Box
 *
 * @param {String|Buffer|Array} secretKey sender's private key.
 * @param {String|Buffer|Array} publicKey recipient's public key.
 * @param {Boolean} easy        Use regular or easy mode. Defaults to regular
 *
 * @see Keys
 * @constructor
 */
module.exports = function Box(publicKey, secretKey, easy) {
    var self = this;

    /** default encoding to use in all string operations */
    self.defaultEncoding = undefined;

    /** Set of keys used to encrypt and decrypt messages */
    self.boxKey = new BoxKey(publicKey, secretKey);

    /** Set mode to regular or easy */
    self.easy = easy || false;

    /**
     * Messages passed to low level API should be padded with zeroBytes at the beginning.
     * This implementation automatically pads the message, so no need to do it on your own
     */
    self.zeroBytes = function() {
        return binding.crypto_box_ZEROBYTES;
    };

    /**
     * Encrypted messages are padded with zeroBoxSize bytes of zeros. If the padding is not
     * there the message will not decrypt successfully.
     */
    self.boxZeroBytes = function() {
        return binding.crypto_box_BOXZEROBYTES;
    };

    /**
     * Padding used in beforenm method. Like zeroBytes this implementation automatically
     * pads the message.
     *
     * @see Const.Box.zeroBytes
     */
    self.beforenmBytes = function() {
        return binding.crypto_box_BEFORENMBYTES;
    };

    /** String name of the default crypto primitive used in box operations */
    self.primitive = function() {
        return binding.crypto_box_PRIMITIVE;
    };

    /**
     * Get the box-key secret keypair object
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
     * The encrypt function encrypts and authenticates a message using the
     * sender's secret key, the receiver's public key, and a nonce n.
     *
     * If no options are given a new random nonce will be generated automatically
     * and both planText and cipherText must be buffers
     *
     * options.encoding is optional and specifies the encoding of the plainText
     * nonce, and cipherText if they are passed as strings. If plainText and
     * nonce are buffers, options.encoding will only affect the resulting
     * cipherText.
     * The basic API leaves it up to the
     * caller to generate a unique nonce for every message, in the high level
     * API a random nonce is generated automatically and you do no need to
     * worry about it.
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
        var cipherText = (self.easy ? binding.crypto_box_easy : binding.crypto_box)(
            buf,
            nonce.get(),
            self.boxKey.getPublicKey().get(),
            self.boxKey.getSecretKey().get());

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

        var nonce = new Nonce(cipherBox.nonce);

        var plainText = (self.easy ? binding.crypto_box_open_easy : binding.crypto_box_open)(
            cipherBox.cipherText,
            nonce.get(),
            self.boxKey.getPublicKey().get(),
            self.boxKey.getSecretKey().get()
        );

        if( encoding ) {
            return plainText.toString(encoding);
        }

        return plainText;
    };

    // Aliases
    self.close = self.encrypt;
    self.open = self.decrypt;
};

