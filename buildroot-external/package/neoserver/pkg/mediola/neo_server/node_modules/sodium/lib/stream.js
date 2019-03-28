/* jslint node: true */
'use strict';

var binding = require('../build/Release/sodium');
var StreamKey = require('./keys/stream-key');
var toBuffer = require('./toBuffer');
var Nonce = require('./nonces/stream-nonce');
var assert = require('assert');

/**
 * @param {String|Buffer|Array} [secretKey]    A valid stream secret key
 * @constructor
 */
module.exports = function Stream(secretKey, encoding) {
    var self = this;

    /** default encoding to use in all string operations */
    self.defaultEncoding = undefined;

    // Init key
    self.secretKey = new StreamKey(secretKey, encoding);

    /** String name of the default crypto primitive used in stream operations */
    self.primitive = function() {
        return binding.crypto_stream_PRIMITIVE;
    };

    /**
     * Get the auth-key secret key object
     * @returns {AuthKey|*}
     */
    self.key = function() {
        return self.secretKey;
    };

    /**
     * Set the default encoding to use in all string conversions
     * @param {String} encoding  encoding to use
     */
    self.setEncoding = function(encoding) {
        assert.equal(typeof encoding, 'string');
        assert.ok(encoding.match(/^(?:utf8|ascii|binary|hex|utf16le|ucs2|base64)$/));
        self.defaultEncoding = encoding;
    };

    /**
     * Get the current default encoding
     * @returns {undefined|String}
     */
    self.getEncoding = function() {
        return self.defaultEncoding;
    };

    self.generate = function(size, nonce, encoding) {
        assert.equal(typeof size, 'number');
        assert.ok(size > 0)

        var n = new Nonce(nonce, encoding);

        var stream = binding.crypto_stream(size, n.get(), self.secretKey.get());
        if( !stream ) {
            return undefined;
        }

        return {
            stream: stream,
            nonce : n.get()
        };
    };

    /**
     * Encrypt the message
     *
     * @param {string|Buffer|Array} message message to authenticate
     * @param {String} [encoding ]  If v is a string you can specify the encoding
     */
    self.encrypt = function(message, encoding) {
        encoding = encoding || self.defaultEncoding || 'utf8';

        var messageBuf = toBuffer(message, encoding);

        var nonce = new Nonce();

        var cipherText = binding.crypto_stream_xor(messageBuf, nonce.get(), self.secretKey.get());

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
     * secret key and a nonce.
     * The function returns the resulting plaintext m.
     *
     * @param {Buffer|String|Array} cipherText  the encrypted message
     * @param {Buffer|String|Array} nonce       the nonce used to encrypt
     * @param {String} [encoding]               the encoding to return the plainText
     */
    self.decrypt = function (cipherBox, encoding) {
        encoding = String(encoding || self.defaultEncoding || 'utf8');

        assert.equal(typeof cipherBox, 'object');
        assert.notEqual(typeof cipherBox.cipherText, 'undefined');
        assert.notEqual(typeof cipherBox.nonce, 'undefined');
        assert.ok(cipherBox.cipherText instanceof Buffer);
        assert.ok(cipherBox.nonce instanceof Buffer);

        var nonce = new Nonce(cipherBox.nonce);

        var plainText = binding.crypto_stream_xor(
            cipherBox.cipherText,
            nonce.get(),
            self.secretKey.get()
        );

        if( encoding ) {
            return plainText.toString(encoding);
        }

        return plainText;
    };
};
