/**
 * Created by bmf on 11/2/13.
 */
var assert = require('assert');
var sodium = require('../build/Release/sodium');

// Test all KeyPair classes
testKey('box-key',sodium.crypto_box_PUBLICKEYBYTES, sodium.crypto_box_SECRETKEYBYTES);
testKey('sign-key',sodium.crypto_sign_PUBLICKEYBYTES, sodium.crypto_sign_SECRETKEYBYTES);
testKey('dh-key',sodium.crypto_scalarmult_BYTES, sodium.crypto_scalarmult_BYTES);

function testKey(modName,sizePkBuffer, sizeSkBuffer) {
    var KeyPair = require('../lib/keys/' + modName);
    if (process.env.COVERAGE) {
        KeyPair = require('../lib-cov/keys/' + modName);
    }

    describe(modName, function () {
        it("generate a valid key", function (done) {
            var key = new KeyPair();
            key.generate();
            var k = key.get();
            assert.ok(key.isValid(k));
            done();
        });

        it("key size should match that of sodium", function (done) {
            var key = new KeyPair();
            assert.equal(key.getPublicKey().size(), sizePkBuffer);
            assert.equal(key.getSecretKey().size(), sizeSkBuffer);
            done();
        });

        it("key bytes should match that of sodium", function (done) {
            var key = new KeyPair();
            assert.equal(key.pkBytes(), sizePkBuffer);
            assert.equal(key.skBytes(), sizeSkBuffer);
            done();
        });

        it("isValid should return false on bad key", function (done) {
            var key = new KeyPair();
            var k = {
                publicKey: Buffer.allocUnsafe(2),
                secretKey: Buffer.allocUnsafe(2)
            };
            assert.ok(!key.isValid(k));
            done();
        });

        it("toString should return a string!", function (done) {
            var key = new KeyPair();
            assert.equal(typeof key.toString(), 'string');
            done();
        });

        it("toString should return a string!", function (done) {
            var key = new KeyPair();
            var k = key.get();

            assert.ok(key.toString('hex').match(/[0-9a-f]+,[0-9A-F]+/i));
            done();
        });

        it("toString should throw with bad encoding!", function (done) {
            var key = new KeyPair();
            assert.throws(function() {
                key.toString('utf8');
            });

            done();
        });

        it("key test string encoding utf8 should throw", function (done) {
            var key = new KeyPair();
            assert.throws(function() {
                var n = key.toString('utf8');
                key.set(n, 'utf8');
            });
            done();
        });

        it("key test string encoding base64 should throw", function (done) {
            var key = new KeyPair();
            assert.throws(function() {
                var n = key.toString('base64');
                key.set(n, 'base64');
            });
            done();
        });

    });
}
