/* jslint node: true */
'use strict';

var binding = require('../build/Release/sodium');
var AuthKey = require('./keys/auth-key');
var toBuffer = require('./toBuffer');
var assert = require('assert');

/**
 * Message Authentication
 *
 * Security model
 *
 * The crypto_auth function, viewed as a function of the message for a uniform
 * random key, is designed to meet the standard notion of unforgeability. This
 * means that an attacker cannot find authenticators for any messages not
 * authenticated by the sender, even if the attacker has adaptively influenced
 * the messages authenticated by the sender. For a formal definition see,
 * e.g., Section 2.4 of Bellare, Kilian, and Rogaway, "The security of the
 * cipher block chaining message authentication code," Journal of Computer and
 * System Sciences 61 (2000), 362–399;
 * http://www-cse.ucsd.edu/~mihir/papers/cbc.html.
 *
 * NaCl does not make any promises regarding "strong" unforgeability; perhaps
 * one valid authenticator can be converted into another valid authenticator
 * for the same message.
 * NaCl also does not make any promises regarding "truncated unforgeability."
 *
 * The secretKey *MUST* remain secret or an attacker could forge valid
 * authenticator tokens
 *
 * If key is not given a new random key is generated
 *
 * @param {String|Buffer|Array} [secretKey]    A valid auth secret key
 * @constructor
 */
module.exports = function  Auth(secretKey, encoding) {
    var self = this;

    /** default encoding to use in all string operations */
    self.defaultEncoding = undefined;

    // Init key
    self.secretKey = new AuthKey(secretKey, encoding);

    /** Size of the authentication token */
    self.bytes = function () {
        return binding.crypto_auth_BYTES;
    };

    /** String name of the default crypto primitive used in auth operations */
    self.primitive = function() {
        return binding.crypto_auth_PRIMITIVE;
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
     * Generate authentication token for message, based on the secret key
     *
     * @param {string|Buffer|Array} message message to authenticate
     * @param {String} [encoding ]  If v is a string you can specify the encoding
     */
    self.generate = function(message, encoding) {
        encoding = encoding || self.defaultEncoding;
        var messageBuf = toBuffer(message, encoding);
        return binding.crypto_auth(messageBuf, self.secretKey.get());
    };

    /**
     * Checks if the token authenticates the message
     *
     * @param {String|Buffer|Array} token    message token
     * @param {String|Buffer|Array} message  message to authenticate
     * @param {String} [encoding]            If v is a string you can specify the encoding
     */
    self.validate = function(token, message, encoding) {
        if(!self.secretKey) {
            throw new Error('Auth: no secret key found');
        }

        encoding = encoding || self.defaultEncoding;

        var tokenBuf = toBuffer(token, encoding);
        var messageBuf = toBuffer(message, encoding);

        return binding.crypto_auth_verify(tokenBuf, messageBuf, self.secretKey.get()) ? false : true;
    };
};
