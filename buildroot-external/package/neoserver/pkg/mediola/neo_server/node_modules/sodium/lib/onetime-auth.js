/* jslint node: true */
'use strict';

var assert = require('assert');
var binding = require('../build/Release/sodium');
var OneTimeKey = require('./keys/onetime-key');
var toBuffer = require('./toBuffer');

/**
 * One Time Message Authentication
 *
 *
 * The secretKey *MUST* remain secret or an attacker could forge valid
 * authenticator tokens
 *
 * If key is not given a new random key is generated
 *
 * @param {String|Buffer|Array} [secretKey]    A valid auth secret key
 * @constructor
 */
module.exports = function OneTimeAuth(secretKey, encoding) {
    var self = this;

    /** default encoding to use in all string operations */
    self.defaultEncoding = undefined;

    // Init key
    self.secretKey = new OneTimeKey(secretKey, encoding);

    /** Size of the authentication token */
    self.bytes = function() {
        return binding.crypto_onetimeauth_BYTES;
    };

    /** String name of the default crypto primitive used in onetimeauth operations */
    self.primitive = function() {
        return binding.crypto_onetimeauth_PRIMITIVE;
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
        return binding.crypto_onetimeauth(messageBuf, self.secretKey.get());
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

        return binding.crypto_onetimeauth_verify(tokenBuf, messageBuf, self.secretKey.get()) ? false : true;
    };
};
