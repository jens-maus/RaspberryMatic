/**
 * Created by bmf on 11/2/13.
 */
var assert = require('assert');
var sodium = require('../build/Release/sodium');

var Box = require('../lib/box');
if (process.env.COVERAGE) {
    Box = require('../lib-cov/box');
}

describe("Box", function () {
    it("encrypt/decrypt and validate message", function (done) {
        var box = new Box();
        box.setEncoding('utf8');
        var cipherBox = box.encrypt("This is a test");
        assert.equal(box.decrypt(cipherBox), "This is a test");
        done();
    });

    it("encrypt should return a valid cipherbox", function (done) {
        var box = new Box();
        box.setEncoding('utf8');
        var cipherBox = box.encrypt("This is a test");
        assert.equal(typeof cipherBox, 'object');
        assert.notEqual(typeof cipherBox.cipherText, 'undefined');
        assert.notEqual(typeof cipherBox.nonce, 'undefined');
        assert.ok(cipherBox.cipherText instanceof Buffer);
        assert.ok(cipherBox.nonce instanceof Buffer);
        done();
    });

    it("encrypt should throw if no first argument", function () {
        var box = new Box();
        assert.throws(function() {
            box.decrypt();
        });
    });

    it("encrypt should throw if the first argument is not an object with `cipherText` and `nonce` properties", function () {
        var box = new Box();
        assert.throws(function() {
            box.decrypt({});
        })
        assert.throws(function() {
            box.decrypt({cipherText: Buffer.from('foo')});
        });
        assert.throws(function() {
            box.decrypt({nonce: 'bar'});
        });
    });

    it("encrypt show throw if cipherBox.cipherText is not a buffer", function () {
        var box = new Box();
        assert.throws(function() {
            box.decrypt({cipherText: "not a buffer", nonce: "foo"});
        });
    });


    it("key size should match that of sodium", function (done) {
        var box = new Box();
        assert.equal(box.key().getPublicKey().size(), sodium.crypto_box_PUBLICKEYBYTES);
        assert.equal(box.key().getSecretKey().size(), sodium.crypto_box_SECRETKEYBYTES);
        done();
    });

    it("generate throw on a bad cipherBox buffer", function (done) {
        var box = new Box();
        var cipherBox = box.encrypt("This is a test", 'utf8');

        cipherBox.cipherText[0] = 99;
        cipherBox.cipherText[1] = 99;
        cipherBox.cipherText[2] = 99;
        assert.throws(function() {
            box.decrypt(cipherBox);
        });
        done();
    });

    it("generate throw on a bad cipherBox buffer", function (done) {
        var box = new Box();
        var cipherBox = box.encrypt("This is a test", 'utf8');

        cipherBox.cipherText[18] = 99;
        cipherBox.cipherText[19] = 99;
        cipherBox.cipherText[20] = 99;
        assert.throws(function() {
            box.decrypt(cipherBox);
        });
        done();
    });

    it("set bad secretKey should fail", function (done) {
        var box = new Box();

        assert.throws(function() {
            box.set(Buffer.allocUnsafe(2));
        });

        done();
    });

    it("set/get secretKey", function (done) {
        var box = new Box();

        box.key().generate();
        var k = box.key().get();

        var auth2 = new Box();
        auth2.key().set(k);

        k2 = auth2.key().get();

        assert.deepEqual(k2, k);
        done();
    });

    it('should set an encoding if a supported encoding is passed to setEncoding', function() {
        var box = new Box();
        box.setEncoding('base64');
        assert.equal(box.defaultEncoding, 'base64');
    });

    it('should fail to set an encoding if an unsupported encoding is passed to setEncoding', function() {
        var box = new Box();
        assert.throws(function () {
            box.setEncoding('unsupported-encoding');
        });
    });
});
