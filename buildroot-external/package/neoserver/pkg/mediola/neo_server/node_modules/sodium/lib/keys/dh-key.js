/**
 * Created by bmf on 11/2/13.
 */
var util = require('util');
var binding = require('../../build/Release/sodium');
var KeyPair = require('./keypair');

var DHKey = function DHKey(publicKey, secretKey, encoding) {
    var self = this;

    KeyPair.call(this);

    self.basePoint = undefined;

    self.init({
        publicKeySize: binding.crypto_scalarmult_BYTES,
        secretKeySize: binding.crypto_scalarmult_BYTES,
        publicKey: publicKey,
        secretKey: secretKey,
        type: 'DHKey'
    });

    self.setBasePoint = function (point, encoding) {
        var b = toBuffer(point, encoding);
        if (b.length != binding.crypto_scalarmult_BYTES) {
            throw new Error('invalid base point length');
        }
        self.basePoint = b;
    };

    self.resetBasePoint = function () {
        if (!self.basePoint) {
            self.basePoint = Buffer.allocUnsafe(binding.crypto_scalarmult_BYTES);
        }

        self.basePoint.fill(0);
        self.basePoint[0] = 9;
    };

    self.generate = function () {
        self.secretKey.generate();
        var pk = binding.crypto_scalarmult(self.secretKey.get(), self.basePoint);
        self.publicKey.set(pk);
    };

    self.makePublicKey = function (secretKey, encoding) {
        self.secretKey.set(secretKey, encoding);
        var pk = binding.crypto_scalarmult(self.secretKey.get(), self.basePoint);
        self.publicKey.set(pk);
    };

    self.resetBasePoint();

    if (!publicKey || !secretKey || !self.isValid({
        'publicKey': publicKey,
        'secretKey': secretKey
    })) {

        if (secretKey) {
            self.makePublicKey(secretKey);
        } else {
            // Generate the keys
            self.generate();
        }

    }

};
util.inherits(DHKey, KeyPair);
module.exports = DHKey;
