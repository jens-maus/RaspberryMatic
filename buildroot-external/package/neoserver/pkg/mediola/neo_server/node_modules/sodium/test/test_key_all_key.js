/**
 * Created by bmf on 11/2/13.
 */
var assert = require('assert');
var sodium = require('../build/Release/sodium');

// Test all key classes
testKey('auth-key',sodium.crypto_auth_KEYBYTES);
testKey('onetime-key',sodium.crypto_onetimeauth_KEYBYTES);
testKey('stream-key',sodium.crypto_stream_KEYBYTES);
testKey('secretbox-key',sodium.crypto_secretbox_KEYBYTES);

function testKey(modName, sizeBuffer) {
    var Key = require('../lib/keys/' + modName);
    if (process.env.COVERAGE) {
        Key = require('../lib-cov/keys/' + modName);
    }

    describe(modName, function () {
        it("generate a valid key", function (done) {
            var key = new Key();
            key.generate();
            var k = key.get();
            assert.ok(key.isValid(k));
            done();
        });

        it("test with initial value", function (done) {
            var k1 = new Key();
            var key = k1.toString();
            var k2 = new Key(key);
            assert.equal(k2.toString(), key);
            done();
        });

        it("key size should match that of sodium", function (done) {
            var key = new Key();
            assert.equal(key.size(), sizeBuffer);
            done();
        });

        it("isValid should return false on bad key", function (done) {
            var key = new Key();
            var k = Buffer.allocUnsafe(2);
            assert.ok(!key.isValid(k));
            done();
        });

        it("isValid should not be ok on bad hex string", function (done) {
            var key = new Key();
            assert.ok(!key.isValid("123"));
            done();
        });

        it("isValid should return false on bad key type", function (done) {
            var key = new Key();
            assert.ok(!key.isValid(123));
            done();
        });

        it("isValid should return true on hex string", function (done) {
            var key = new Key();
            key.generate();
            var k = key.get();
            assert.ok(key.isValid(k.toString('hex'),'hex'));
            done();
        });

        it("isValid should return throw on bad encoding string", function (done) {
            var key = new Key();
            key.generate();
            var k = key.get();
             assert.throws(function() {
                assert.ok(key.isValid(k.toString('hex'),'sex'));
            });
            done();
        });

        it("wipe should zero out the key", function (done) {
            var key = new Key();
            key.generate();
            key.wipe();
            var k = key.get();
            for(var i = 0; i < k.length; i++ ) {
                assert.equal(k[i], 0);
            }
            done();
        });

        it("set should throw on bad key length", function (done) {
            var key = new Key();
             assert.throws(function() {
                key.set(Buffer.allocUnsafe(2));
            });
            done();
        });

        it("set/get secretKey", function (done) {
            var key = new Key();

            key.generate();
            var k = key.get();

            var key2 = new Key();
            key2.set(k);

            k2 = key2.get();

            assert.deepEqual(k2, k);

            done();
        });

        it("toString should return a string!", function (done) {
            var key = new Key();
            key.generate();
            assert.equal(typeof key.toString(), 'string');
            done();
        });

        it("toString should return a string!", function (done) {
            var key = new Key();
            key.generate();
            var k = key.get();
            assert.equal(key.toString('hex'), k.toString('hex'));
            done();
        });

        it("toString should throw with bad encoding!", function (done) {
            var key = new Key();
             assert.throws(function() {
                key.toString('sex');
            });

            done();
        });

        it("key test string encoding utf8 should throw", function (done) {
            var key = new Key();
             assert.throws(function() {
                var n = key.toString('utf8');
                key.set(n, 'utf8');
            });
            done();
        });

        it("key test string encoding hex", function (done) {
            var key = new Key();
            var n = key.toString('hex');
            key.set(n, 'hex');
            done();
        });

        it("key test string encoding base64 should throw", function (done) {
            var key = new Key();
            var n = key.toString('base64');
            key.set(n, 'base64');
            done();
        });

        it("key test string encoding binary", function (done) {
            var key = new Key();
             assert.throws(function() {
                var n = key.toString('binary');
                key.set(n, 'binary');
            });
            done();
        });

        it("key test string encoding ascii should throw", function (done) {
            var key = new Key();
             assert.throws(function() {
                var n = key.toString('ascii');
                key.set(n, 'ascii');
            });
            done();
        });

        it("key test string encoding utf16le should throw", function (done) {
            var key = new Key();
             assert.throws(function() {
                var n = key.toString('utf16le');
                key.set(n, 'utf16le');
            });
            done();
        });

        it("key test string encoding ucs2 should throw", function (done) {
            var key = new Key();
             assert.throws(function() {
                var n = key.toString('ucs2');
                key.set(n, 'ucs2');
            });
            done();
        });

    });
}
