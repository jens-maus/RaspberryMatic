/**
 * Created by bmf on 11/3/13.
 */
 /* jslint node: true */
'use strict';

var util = require('util');
var binding = require('../../build/Release/sodium');
var CryptoBaseBuffer = require('../crypto-base-buffer');

var SecretBox = function SecretBoxNonce(nonce, encoding) {
    var self = this;

    CryptoBaseBuffer.call(this);

    self.setValidEncodings(['hex', 'base64']);

    self.init({
        expectedSize: binding.crypto_secretbox_NONCEBYTES,
        buffer: nonce,
        encoding: encoding,
        type: 'SecretBoxNonce'
    });
    
};
util.inherits(SecretBox, CryptoBaseBuffer);
module.exports = SecretBox;