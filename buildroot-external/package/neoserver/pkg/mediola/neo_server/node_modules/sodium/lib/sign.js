/**
 * Created by bmf on 11/2/13.
 *
 * Documentation of crypto http://nacl.cr.yp.to/box.html
 */
 /* jslint node: true */
'use strict';

var binding = require('../build/Release/sodium');
var assert = require('assert');
var SignKey = require('./keys/sign-key');
var toBuffer = require('./toBuffer');


/**
 * Public-key authenticated message signatures: Sign
 *
 * @param {String|Buffer|Array} secretKey sender's private key.
 * @param {String|Buffer|Array} publicKey recipient's private key.
 *
 * @see Keys
 * @constructor
 */
function Sign(key) {
    var self = this;

    /** default encoding to use in all string operations */
    self.defaultEncoding = undefined;

    if( key instanceof SignKey) {
        self.iKey = key;
    }
    else {
        /** Set of keys used to encrypt and decrypt messages */
        self.iKey = new SignKey();
    }

    /** Size of the generated message signature */
    self.bytes = function() {
        return binding.crypto_sign_BYTES;
    };

    /** String name of the default crypto primitive used in sign operations */
    self.primitive = function() {
        return binding.crypto_sign_PRIMITIVE;
    };

    /**
     * Get the keypair object
     * @returns {SignKey|*}
     */
    self.key = function() {
        return self.iKey;
    };

    /**
     * @return {Number} The size of the message signature
     */
    self.size = function() {
        return binding.crypto_sign_BYTES;
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
     * Digitally sign message
     *
     * @param {Buffer|String|Array} message  message to sign
     * @param {String} [encoding]             encoding of message string
     *
     * @returns {Object}                       cipher box
     */
    self.sign = function (message, encoding) {
        encoding = String(encoding) || self.defaultEncoding || 'utf8';

        var buf = toBuffer(message, encoding);

        var signature = binding.crypto_sign(buf, self.iKey.sk().get());
        if( !signature ) {
            return undefined;
        }

        return {
            sign: signature,
            publicKey: self.iKey.pk().get()
        };
    };

    /**
     * Digitally sign message, using detached signature
     *
     * @param {Buffer|String|Array} message  message to sign
     * @param {String} [encoding]            encoding of message string
     *
     * @returns {Object} cipher box
     */
    self.signDetached = function (message, encoding) {
        encoding = String(encoding) || self.defaultEncoding || 'utf8';

        var buf = toBuffer(message, encoding);

        var signature = binding.crypto_sign_detached(buf, self.iKey.sk().get());
        if( !signature ) {
            return undefined;
        }

        return {
            sign: signature,
            publicKey: self.iKey.pk().get()
        };
    };
}

/**
 * Verify digital signature
 *
 * @param {Buffer|String|Array} cipherText  the signed message
 */
Sign.verify = function (signature) {
    assert(typeof signature == 'object' && signature.hasOwnProperty('sign') && signature.hasOwnProperty('publicKey'));
    return binding.crypto_sign_open(signature.sign, signature.publicKey);
};

/**
 * Verify digital signature (detached mode)
 *
 * @param {Buffer|String|Array} signature  the signature
 * @param {Buffer|String|Array} message    the message
 *
 * returns true if verified successfully, false otherwise.
 */
Sign.verifyDetached = function (signature, message) {
    assert(typeof signature == 'object' && signature.hasOwnProperty('sign') && signature.hasOwnProperty('publicKey'));
    return binding.crypto_sign_verify_detached(signature.sign, message, signature.publicKey);
};

module.exports = Sign;
