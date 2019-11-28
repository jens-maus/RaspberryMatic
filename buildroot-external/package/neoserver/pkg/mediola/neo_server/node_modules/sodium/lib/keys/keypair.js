/**
 * Created by bmf on 11/2/13.
 */
 /* jslint node: true */
'use strict';

var assert = require('assert');
var CryptoBaseBuffer = require('../crypto-base-buffer');

module.exports = function KeyPair() {
    var self = this;

    /** secret key */
    self.secretKey = new CryptoBaseBuffer();
    self.secretKeySize = 0;

    /** public key */
    self.publicKey = new CryptoBaseBuffer();
    self.publicKeySize = 0;

    self.type = undefined;

    /** default encoding to use in all string operations */
    self.defaultEncoding = undefined;

    self.init = function(options) {
        options = options || {};

        if( !options.type ) {
            throw new Error('[KeyPair] type not given in init');
        }
        self.type = options.type;

        if( !options.publicKeySize ) {
            throw new Error('[KeyPair] public key size not given');
        }
        self.publicKeySize = options.publicKeySize;

        if( !options.secretKeySize ) {
            throw new Error('[KeyPair] secret key size not given');
        }
        self.secretKeySize = options.secretKeySize;

        // init both buffers
        self.publicKey.init({
            expectedSize: options.publicKeySize,
            type: self.type + 'PublicKey'
        });

        self.secretKey.init({
            expectedSize: options.secretKeySize,
            type: self.type + 'SecretKey'
        });

        // We will only accept hex string representations of keys
        self.publicKey.setValidEncodings(['hex', 'base64']);
        self.secretKey.setValidEncodings(['hex', 'base64']);

        // the default encoding to us in all string set/toString methods is Hex
        self.publicKey.setEncoding('base64');
        self.secretKey.setEncoding('base64');

        // Public Key
        self.setPublicKey(options.publicKey, options.encoding);

        // Secret Key
        self.setSecretKey(options.secretKey, options.encoding);
    };

    /** Box Public Key buffer size in bytes */
    self.publicKeyBytes = function() {
        return self.publicKeySize;
    };

    /** Box Public Key buffer size in bytes */
    self.secretKeyBytes = function() {
        return self.secretKeySize;
    };

    /* Aliases */
    self.pkBytes = self.publicKeyBytes;
    self.skBytes = self.secretKeyBytes;

    /**
     * Set the default encoding to use in all string conversions
     * @param {String} encoding  encoding to use
     */
    self.setEncoding = function(encoding) {
        assert(!!encoding.match(/^(?:utf8|ascii|binary|hex|utf16le|ucs2|base64)$/), 'Encoding ' + encoding + ' is currently unsupported.');
        self.defaultEncoding = encoding;
        self.publicKey.setEncoding(encoding);
        self.secretKey.setEncoding(encoding);
    };

    /**
     * Get the current default encoding
     * @returns {undefined|String}
     */
    self.getEncoding = function() {
        return self.defaultEncoding;
    };

    /**
     * Check if key pair is valid
     * @param keys {Object} an object with secrteKey, and publicKey members
     * @returns {boolean} true is both public and secret keys are valid
     */
    self.isValid = function(keys, encoding) {
        assert.equal(typeof keys, 'object');
        assert.ok(keys.publicKey);
        assert.ok(keys.secretKey);

        encoding = encoding || self.defaultEncoding;

        return self.publicKey.isValid(keys.publicKey, encoding) &&
               self.secretKey.isValid(keys.secretKey, encoding);
    };

    /**
     * Wipe keys securely
     */
    self.wipe = function() {
        self.publicKey.wipe();
        self.secretKey.wipe();
    };

    /**
     * Generate a random key pair
     */
    self.generate = function() {
        throw new Error('KeyPair: this method should be implemented in each sub class');
    };

    /**
     *  Getter for the public key
     * @returns {undefined| Buffer} public key
     */
    self.getPublicKey = function() {
        return self.publicKey;
    };

    /**
     *  Getter for the secretKey
     * @returns {undefined| Buffer} secret key
     */
    self.getSecretKey = function() {
        return self.secretKey;
    };

    self.pk = self.getPublicKey;
    self.sk = self.getSecretKey;

    /**
     *  Getter for the key pair
     * @returns {Object} with both public and private keys
     */
    self.get = function() {
        return {
            'publicKey' : self.publicKey.get(),
            'secretKey' : self.secretKey.get()
        };
    };

    /**
     * Set the secret key to a known value
     * @param v {String|Buffer|Array} the secret key
     * @param encoding {String} optional. If v is a string you can specify the encoding
     */
    self.set = function(keys, encoding) {
        assert.equal(typeof keys, 'object');

        if( keys instanceof KeyPair ) {
            self.secretKey.set(keys.sk(), encoding);
            self.publicKey.set(keys.pk(), encoding);
        }
        else {
            encoding = encoding || self.defaultEncoding;
            if( typeof keys === 'object' ) {
                if( keys.secretKey ) {
                    self.secretKey.set(keys.secretKey, encoding);
                }
                if( keys.publicKey ) {
                    self.publicKey.set(keys.publicKey, encoding);
                }
            }
        }
    };

    self.setPublicKey = function(key, encoding) {
        if( key instanceof KeyPair ) {
            self.publicKey = key.pk();
        }
        else if( key instanceof CryptoBaseBuffer ) {
            if( key.size() == self.publicKeySize ) {
                self.publicKey = key;
            }
        }
        else {
            self.publicKey.init({
                expectedSize: self.publicKeySize,
                buffer: key,
                encoding: encoding,
                type: self.type + 'PublicKey'
            });
        }
    };

    self.setSecretKey = function(key, encoding) {
        if( key instanceof KeyPair ) {
            self.secretKey = key.sk();
        }
        else if( key instanceof CryptoBaseBuffer ) {
            if( key.size() == self.secretKeySize ) {
                self.secretKey = key;
            }
        }
        else {
            self.secretKey.init({
                expectedSize: self.secretKeySize,
                buffer: key,
                encoding: encoding,
                type: self.type + 'SecretKey'
            });
        }
    };


    /**
     * Convert the secret key to a string object
     * @param encoding {String} optional sting encoding. defaults to 'hex'
     */
    self.toString = function(encoding) {
        encoding = encoding || self.defaultEncoding;

        return self.secretKey.toString(encoding) + "," +
               self.publicKey.toString(encoding);
    };

    /**
     * Convert the secret key to a JSON object
     * @param encoding {String} optional sting encoding. defaults to 'hex'
     */
    self.toJson = function(encoding) {
        encoding = encoding || self.defaultEncoding;

        var out = '{';
        if( self.secretKey ) {
            out += '"secretKey" :"' + self.secretKey.toString(encoding) + '"';
        }
        if( self.secretKey && self.publicKey ) {
            out += ', ';
        }
        if( self.publicKey ) {
            out += '"publicKey" :"' + self.publicKey.toString(encoding) + '"';
        }
        out += '}';
        return out;
    };
};
