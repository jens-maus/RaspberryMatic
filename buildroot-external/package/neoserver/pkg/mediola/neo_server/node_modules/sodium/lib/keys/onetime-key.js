/**
 * Created by bmf on 11/2/13.
 */
var util = require('util');
var binding = require('../../build/Release/sodium');
var CryptoBaseBuffer = require('../crypto-base-buffer');

var OneTime = function OneTimeAuthKey(key, encoding) {
    var self = this;

    CryptoBaseBuffer.call(this);

    self.init({
        expectedSize: binding.crypto_onetimeauth_KEYBYTES,
        buffer: key,
        encoding: encoding,
        type: 'OneTimeAuthKey'
    });
    self.setValidEncodings(['hex', 'base64']);
    
};
util.inherits(OneTime, CryptoBaseBuffer);
module.exports = OneTime;