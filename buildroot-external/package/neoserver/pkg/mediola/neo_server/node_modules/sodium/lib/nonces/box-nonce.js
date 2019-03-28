/**
 * Created by bmf on 11/3/13.
 */
 /* jslint node: true */
'use strict';

var util = require('util');
var binding = require('../../build/Release/sodium');
var CryptoBaseBuffer = require('../crypto-base-buffer');

var Box = function BoxNonce(nonce, encoding) {
    var self = this;

    CryptoBaseBuffer.call(this);

    self.setValidEncodings(['hex', 'base64']);

    self.init({
        expectedSize: binding.crypto_box_NONCEBYTES,
        buffer: nonce,
        encoding: encoding,
        type: 'BoxNonce'
    });
    
};
util.inherits(Box, CryptoBaseBuffer);
module.exports = Box;