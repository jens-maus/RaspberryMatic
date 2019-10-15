/**
 * Created by bmf on 11/2/13.
 */
 /* jslint node: true */
'use strict';

var util = require('util');
var binding = require('../../build/Release/sodium');
var CryptoBaseBuffer = require('../crypto-base-buffer');

/**
 * Message Authentication Secret Key
 *
 * @param {String|Buffer|Array} key secret key
 */
var Auth = function AuthKey(key, encoding) {
    var self = this;

    CryptoBaseBuffer.call(this);

    self.init({
        expectedSize: binding.crypto_auth_KEYBYTES,
        buffer: key,
        encoding: encoding,
        type: 'AuthKey'
    });
    
    self.setValidEncodings(['hex', 'base64']);
    
};
util.inherits(Auth, CryptoBaseBuffer);
module.exports = Auth;