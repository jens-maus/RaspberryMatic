/**
 * Created by bmf on 11/2/13.
 */
 /* jslint node: true */
'use strict';

var assert = require('assert');
var binding = require('../build/Release/sodium');
var toBuffer = require('./toBuffer');

module.exports =  function CryptoBaseBuffer() {
    var self = this;

    /**
     * Expected size of the buffer.
     * All buffers need to have expectedSize bytes to be valid
     * */
    self.expectedSize = 0;          // This should be set to the appropriate Lib Sodium constant

    /** internal state buffer */
    self.baseBuffer = undefined;

    /** default encoding to use in all string operations */
    self.defaultEncoding = undefined;

    /** Default valid string encoding schemes */
    self.validEncodings = /^(?:hex|base64)$/;

    /** Type of data stored in the buffer. (key, pulicKey, secretKey, nonce) **/
    self.type = undefined;

    /**
     * Initialize object
     * If a key is not given generate a new random key.
     *
     * Valid keys, once converted to a node buffer, must have expectedSize in length.
     * If a key is represented by a string the string length depends on the encoding
     * so do not rely on string lengths to calculate key sizes.
     *
     * @param {number} expectedSize          expected size of the buffer in bytes
     * @param {String|Buffer|Array} [value]  value to initialize the buffer with
     * @param {Srting} [encoding]            encoding to use in conversion if value is a string. Defaults to 'hex'
     */
    self.init = function(options) {
        options = options || {};

        assert(typeof options.expectedSize == 'number' && options.expectedSize > 0, 'options.expectedSize > 0');

        if ( !options.type ) {
            throw self.error('type must be passed to init');
        }
        assert(typeof options.type == 'string');

        self.type = options.type;

        if ( !options.expectedSize ) {
            throw self.error('expectedSize must be passed to init');
        }
        self.expectedSize = options.expectedSize;

        if( !options.buffer ) {
            self.generate();
            return;
        }

        self.set(options.buffer, options.encoding);
    };

    /**
     * Set the default encoding to use in all string conversions
     * @param {String} encoding  encoding to use
     */
    self.setEncoding = function(encoding) {
        assert(typeof encoding == 'string');
        assert(encoding.match(self.validEncodings));
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
     * Return the type of data stored in the buffer.
     * Example: "BoxKeyPublicKey" for a Box object's public key
     * @returns {undefined|String}
     */
    self.getType = function() {
        return self.type;
    };

    /**
     * Set the valid string encodings
     *
     * A lot of cryptographic functions rely on random buffer data that cannot
     * be accurately converted to and from some encoding schemes. This method
     * allows you to restrict the string encoding to settings you know will work
     *
     * @param {Array} encList   array of strings with supported encodings
     */
    self.setValidEncodings = function(encList) {
        if( !encList ) {
            return;
        }
        assert(encList instanceof Array);
        var rxStr = '^(?:';
        var l = encList.length;
        for(var i=0; i < l; i++) {
            if( encList[i] === 'utf8' ) {
                throw self.error('utf8 cannot be used to decode random byte buffers. Crypto is "random"');
            }
            rxStr += encList[i];
            if( i != l-1 ) rxStr += '|';
        }
        rxStr += ')$';

        self.validEncodings = new RegExp(rxStr);
    };

    /**
     * Generate a new Error appropriate to use with throw
     * @param errorMessage
     * @returns {Error}
     */
    self.error = function(errorMessage) {
        return new Error('[CryptoBaseBuffer] ' + self.type + ' ' + errorMessage);
    };

    /**
     * Convert value into a buffer
     *
     * @param {String|Buffer|Array} value  a buffer, and array of bytes or a string that you want to convert to a buffer
     * @param {String} [encoding]          encoding to use in conversion if value is a string. Defaults to 'hex'
     * @returns {*}
     */
    self.toBuffer = function(value, encoding) {
        encoding = encoding || self.defaultEncoding;

        if( encoding && !encoding.match(self.validEncodings)) {
            throw self.error('invalid encoding');
        }

        return toBuffer(value, encoding);
    };

    /**
     * Get the length of the buffer
     * @returns {number} length in bytes of the buffer
     */
    self.size = function() {
        return self.expectedSize;
    };

    /**
     * Get the length of the buffer
     * @returns {number} length in bytes of the buffer
     */
    self.bytes = self.size;

    /**
     * Check if value could be used by CryptoBaseBuffer as a buffer
     *
     * @param {String|Buffer|Array} value to test
     * @param {String} [encoding]   encoding to use in conversion if value is a string. Defaults to 'hex'
     * @returns {boolean} true      if value could be used as a CryptoBaseBuffer
     */
    self.isValid = function(value, encoding) {
        if( !self.expectedSize ) {
            throw self.error('expectedSize must be set in the sub-class by calling init()');
        }

        if( typeof value === 'string' ) {
            encoding = encoding || self.defaultEncoding || 'hex';

            if( encoding === 'utf8' ) {
                throw self.error('utf8 cannot be used to encode/decode random byte buffers. Crypto is "random"');
            }

            if( encoding && !encoding.match(self.validEncodings)) {
                throw self.error('invalid encoding');
            }

            return Buffer.byteLength(value, encoding) == self.expectedSize;
        }

        if( typeof value == 'object' ) {
            if( value instanceof Array || value instanceof Buffer ) {
                return value.length == self.expectedSize;
            }
            if( value instanceof CryptoBaseBuffer ) {
                return value.size() == self.expectedSize;
            }
        }
        return false;
    };

    /**
     * Wipe buffer securely
     */
    self.wipe = function() {
        if( self.baseBuffer ) {
            binding.memzero(self.baseBuffer);
        }
    };

    /**
     * Fill buffer with random bytes
     * This method can be redefined in each sub-class to implement
     * the specific needs of that class
     */
    self.generate = function() {
        if( !self.expectedSize ) {
            throw self.error('expectedSize must be set in the sub-class by calling init()');
        }
        self.baseBuffer = Buffer.allocUnsafe(self.expectedSize);
        binding.randombytes_buf(self.baseBuffer);
    };

    /**
     *  Getter for the baseBuffer
     * @returns {undefined| Buffer} secret key
     */
    self.get = function() {
        return self.baseBuffer;
    };

    /**
     * Set the secret key to a known value
     * @param {String|Buffer|Array} value   the secret value to set the buffer to
     * @param {String} [encoding]           If v is a string you can specify the encoding.
     */
    self.set = function(value, encoding) {
        encoding = encoding || self.defaultEncoding;

        if( !value ) {
            self.wipe();
            return;
        }

        if( encoding && !encoding.match(self.validEncodings)) {
            throw self.error('invalid encoding');
        }

        if( !self.isValid(value, encoding) ) {
            throw self.error('baseBuffer length must be ' + self.expectedSize + ' bytes');
        }

        if( value instanceof CryptoBaseBuffer ) {
            self.baseBuffer = value;
        }
        else {
            self.baseBuffer = self.toBuffer(value, encoding);
        }
    };

    /**
     * Convert the secret key to a string object
     * @param encoding {String} optional sting encoding. defaults to 'hex'
     */
    self.toString = function(encoding) {
        encoding = encoding || self.defaultEncoding || 'hex';

        if( encoding.toLowerCase() === 'utf8' ) {
            throw self.error('utf8 cannot be used to decode random byte buffers. Crypto is "random"');
        }

        if( encoding && !encoding.match(self.validEncodings)) {
            throw self.error('invalid encoding');
        }

        if( !self.baseBuffer ) {
            throw self.error('buffer has not been generated or set yet.');
        }

        return self.baseBuffer.toString(encoding);
    };

    /**
     * Serialize a CryptoBaseBuffer
     *
     * @param {String} [encoding]   encoding used to convert the buffer to a string
     * @returns {string}            parsable JSON string
     */
    self.serialize = function(encoding) {
        encoding = encoding || self.defaultEncoding || 'hex';

        if( encoding.toLowerCase() === 'utf8' ) {
            throw self.error('utf8 cannot be used to decode random byte buffers. Crypto is "random"');
        }

        var out = '{ "buffer:"' + self.toString(encoding) + ',';
        out += ' "encoding:"' + encoding + '}';
        return out;
    };

    /**
     * Deserialize object. Take a parsable JSON string and create a valid buffer object
     *
     * @param {Object} obj    parsable JSON String
     */
    self.deserialize = function(obj) {
        var o;
        try {
            o = JSON.parse(obj);
        }
        catch (e) {
            throw self.error('invalid object to deserialize: ' + e.message);
        }

        self.set(o.buffer, o.encoding);
    };

    // some aliases
    self.toJSON = self.serialize;
    self.parse = self.deserialize;
};
