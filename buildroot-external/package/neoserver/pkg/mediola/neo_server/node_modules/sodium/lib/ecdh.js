/**
 * Created by bmf on 11/2/13.
 *
 * Documentation of crypto http://nacl.cr.yp.to/box.html
 * @
 * @test ../test/test_ecdh.js
 */
/* jslint node: true */
'use strict';

var binding = require('../build/Release/sodium');
var DHKey = require('./keys/dh-key');

module.exports = function ECDH(publicKey, secretKey) {
    var self = this;

    self.iSecret = undefined;
    self.iSessionKey = undefined;

    self.iKey = new DHKey(publicKey, secretKey);

    self.secret = function () {
        if (!self.iSecret) {
            self.iSecret = binding.crypto_scalarmult(self.iKey.sk().get(), self
                .iKey.pk().get());
        }
        return self.iSecret;
    };

    self.reset = function () {
        self.iSecret = undefined;
        self.iSessionKey = undefined;
    };

    self.sessionKey = function () {
        if (!self.iSecret) {
            self.iSecret = binding.crypto_scalarmult(self.iKey.sk().get(), self
                .iKey.pk().get());
        }
        if (!self.iSessionKey) {
            self.iSessionKey = binding.crypto_hash_sha256(self.iSecret);
        }
        return self.iSessionKey;
    };
};
