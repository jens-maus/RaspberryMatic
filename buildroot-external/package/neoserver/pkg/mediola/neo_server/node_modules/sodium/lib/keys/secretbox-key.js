var util = require('util');
var binding = require('../../build/Release/sodium');
var CryptoBaseBuffer = require('../crypto-base-buffer');

var SecretBox = function SecretBoxKey(key, encoding) {
    var self = this;

    CryptoBaseBuffer.call(this);

    self.init({
        expectedSize: binding.crypto_secretbox_KEYBYTES,
        buffer: key,
        encoding: encoding,
        type: 'SecretBoxKey'
    });

    self.setValidEncodings(['hex', 'base64']);
    
};
util.inherits(SecretBox, CryptoBaseBuffer);
module.exports = SecretBox;