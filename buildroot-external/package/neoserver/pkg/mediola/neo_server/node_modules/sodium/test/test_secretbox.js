/**
 * Created by bmf on 11/2/13.
 */
var assert = require('assert');
var sodium = require('../build/Release/sodium');

var SecretBox = require('../lib/secretbox');
if (process.env.COVERAGE) {
    SecretBox = require('../lib-cov/secretbox');
}

describe("SecretBox", function () {
    it("encrypt/decrypt and validate message", function (done) {
        var box = new SecretBox();
        box.setEncoding('utf8');
        var cipherBox = box.encrypt("This is a test");
        assert.equal(box.decrypt(cipherBox), "This is a test");
        done();
    });

    it("encrypt should return a valid cipherbox", function (done) {
        var box = new SecretBox();
        box.setEncoding('utf8');
        var cipherBox = box.encrypt("This is a test");
        assert.equal(typeof cipherBox, 'object');
        assert.notEqual(typeof cipherBox.cipherText, 'undefined');
        assert.notEqual(typeof cipherBox.nonce, 'undefined');
        assert.ok(cipherBox.cipherText instanceof Buffer);
        assert.ok(cipherBox.nonce instanceof Buffer);
        done();
    });

    it("key size should match that of sodium", function (done) {
        var box = new SecretBox();
        assert.equal(box.key().size(), sodium.crypto_secretbox_KEYBYTES);
        done();
    });

    it("generate throw on a bad cipherBox buffer", function (done) {
        var box = new SecretBox();
        var cipherBox = box.encrypt("This is a test", 'utf8');

        cipherBox.cipherText[0] = 99;
        cipherBox.cipherText[1] = 99;
        cipherBox.cipherText[2] = 99;
        assert.throws(function() {
            box.decrypt(cipherBox);
        });
        done();
    });

    it("generate return undefined on an altered cipherText", function (done) {
        var box = new SecretBox();
        var cipherBox = box.encrypt("This is a test", 'utf8');

        cipherBox.cipherText[18] = 99;
        cipherBox.cipherText[19] = 99;
        cipherBox.cipherText[20] = 99;
        var plainText = box.decrypt(cipherBox);
        if (!plainText) {
            done();
        }
    });

    it("set bad secretKey should fail", function (done) {
        var box = new SecretBox();

        assert.throws(function() {
            box.set(Buffer.allocUnsafe(2));
        });

        done();
    });

    it("set/get secretKey", function (done) {
        var box = new SecretBox();

        box.key().generate();
        var k = box.key().get();

        var auth2 = new SecretBox();
        auth2.key().set(k);

        k2 = auth2.key().get();

        assert.deepEqual(k2, k);
        done();
    });

});
