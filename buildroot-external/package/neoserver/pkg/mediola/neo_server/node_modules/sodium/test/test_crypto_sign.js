/**
 * Created by bmf on 10/31/13.
 */
"use strict";

var assert = require('assert');
var crypto = require('crypto');
var sodium = require('../build/Release/sodium');

describe('Sign', function() {
    it('crypto_sign_keypair should return a pair of keys', function(done) {
        var keys = sodium.crypto_sign_keypair();
        assert.equal(typeof keys, 'object');
        assert.notEqual(typeof keys.publicKey, 'undefined');
        assert.notEqual(typeof keys.secretKey, 'undefined');
        assert.equal(keys.publicKey.length, sodium.crypto_sign_PUBLICKEYBYTES);
        assert.equal(keys.secretKey.length, sodium.crypto_sign_SECRETKEYBYTES);
        done();
    });

    it('a signed message should verify correctly', function(done) {
        var keys = sodium.crypto_sign_keypair();
        var message = Buffer.from("Libsodium is cool", 'utf8');
        var signedMsg = sodium.crypto_sign(message, keys.secretKey);

        var message2 = sodium.crypto_sign_open(signedMsg, keys.publicKey);
        assert.equal(message2.toString('utf8'), message.toString('utf8'));
        done();
    });

    it('should accept a zero length message', function(done) {
        var keys = sodium.crypto_sign_ed25519_keypair();
        var signedMsg = sodium.crypto_sign_ed25519_detached(Buffer.allocUnsafe(0), keys.secretKey)
        done();
    });

    it('a detached message signature should verify correctly', function(done) {
        var keys = sodium.crypto_sign_keypair();
        var message = Buffer.from("Libsodium is cool", 'utf8');
        var signature = sodium.crypto_sign_detached(message, keys.secretKey);

        var verified = sodium.crypto_sign_verify_detached(signature, message, keys.publicKey);
        assert.strictEqual(verified, true);
        done();
    });

    it('a modified detached message signature should not verify correctly', function(done) {
        var keys = sodium.crypto_sign_keypair();
        var message = Buffer.from("Libsodium is cool", 'utf8');
        var signature = sodium.crypto_sign_detached(message, keys.secretKey);
        signature.writeFloatLE(Math.random(), 0);
        var verified = sodium.crypto_sign_verify_detached(signature, message, keys.publicKey);
        assert.strictEqual(verified, false);
        done();
    });

    it('should throw with less than 2 arguments', function(done) {
        var keys = sodium.crypto_sign_keypair();
        var message = Buffer.from("Libsodium is cool", 'utf8');

         assert.throws(function() {
            var signedMsg = sodium.crypto_sign(message);
        });
        done();
    });

    it('should throw with no params', function(done) {
        var keys = sodium.crypto_sign_keypair();
        var message = Buffer.from("Libsodium is cool", 'utf8');

         assert.throws(function() {
            var signedMsg = sodium.crypto_sign();
        });
        done();
    });

    it('should throw with a small key', function(done) {
        var message = Buffer.from("Libsodium is cool", 'utf8');

         assert.throws(function() {
            var signedMsg = sodium.crypto_sign(message, Buffer.allocUnsafe(12));
        });
        done();
    });

    it('should test bad arg 1', function(done) {
        var message = Buffer.from("Libsodium is cool", 'utf8');
        var keys = sodium.crypto_sign_keypair();
         assert.throws(function() {
            var signedMsg = sodium.crypto_sign(1, keys.secretKey);
        });
        done();
    });

    it('should test bad arg 2', function(done) {
        var message = Buffer.from("Libsodium is cool", 'utf8');
        var keys = sodium.crypto_sign_keypair();
         assert.throws(function() {
            var signedMsg = sodium.crypto_sign(message, 1);
        });
        done();
    });

    it('should test bad arg 2', function(done) {
        var message = Buffer.from("Libsodium is cool", 'utf8');
        var keys = sodium.crypto_sign_keypair();
         assert.throws(function() {
            var signedMsg = sodium.crypto_sign(message, "123");
        });
        done();
    });
});
