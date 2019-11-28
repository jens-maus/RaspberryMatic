var util = require('util');
var binding = require('../../build/Release/sodium');
var CryptoBaseBuffer = require('../crypto-base-buffer');

var Stream = function StreamKey(key, encoding) {
    var self = this;

    CryptoBaseBuffer.call(this);

    self.init({
        expectedSize: binding.crypto_stream_KEYBYTES,
        buffer: key,
        encoding: encoding,
        type: 'StreamKey'
    });
    
    self.setValidEncodings(['hex', 'base64']);
    
};

util.inherits(Stream, CryptoBaseBuffer);
module.exports = Stream;