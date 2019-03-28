/**
 * Created by bmf on 11/3/13.
 */
 /* jslint node: true */
'use strict';

var util = require('util');
var binding = require('../../build/Release/sodium');
var CryptoBaseBuffer = require('../crypto-base-buffer');

var Stream = function StreamNonce(nonce, encoding) {
    var self = this;

    CryptoBaseBuffer.call(this);

    self.setValidEncodings(['hex', 'base64']);

    self.init({
        expectedSize: binding.crypto_stream_NONCEBYTES,
        buffer: nonce,
        encoding: encoding,
        type: 'StreamNonce'
    });
    
};
util.inherits(Stream, CryptoBaseBuffer);
module.exports = Stream;