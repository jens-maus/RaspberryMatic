/**
 * Created by bmf on 10/31/13.
 */
"use strict";

var assert = require('assert');
var crypto = require('crypto');
var sodium = require('../build/Release/sodium');

describe('Auth', function() {
    it('should return a token', function(done) {
        var buf = Buffer.alloc(100, 1);
        var key = Buffer.alloc(sodium.crypto_auth_KEYBYTES);
        key[0] = 9;
        key[1] = 9;
        var r = sodium.crypto_auth(buf, key);
        var token = r.toString('hex');
        assert.equal(token, "22b4c0615f736278655b8e8e7f63bda982f2c96c661c7d34e1d63488bd6c9df9");
        done();
    });

    it('should validate', function(done) {
        var buf = crypto.randomBytes(256);
        var key = crypto.randomBytes(sodium.crypto_auth_KEYBYTES);
        var token = sodium.crypto_auth(buf, key);
        var r = sodium.crypto_auth_verify(token, buf, key);
        assert.equal(r, 0);
        done();
    });
});

describe('crypto_auth check paramters', function() {
    var buf = crypto.randomBytes(256);
    var key = crypto.randomBytes(sodium.crypto_auth_KEYBYTES);

    it('check param 1', function(done) {
        var b = "buf";
        var k = key;
        assert.throws(function() {
            var token = sodium.crypto_auth(b, k);
        });

        b = 5;
        assert.throws(function() {
            var token = sodium.crypto_auth(b, k);
        });
        done();
    });

    it('check param 2', function(done) {
        var b = buf;
        var k = "key";
        assert.throws(function() {
            var token = sodium.crypto_auth(b, k);
        });

        k = 5;
        assert.throws(function() {
            var token = sodium.crypto_auth(b, k);
        });
        done();
    });

});

describe('crypto_auth_verify check paramters', function() {
    var buf = crypto.randomBytes(256);
    var key = crypto.randomBytes(sodium.crypto_auth_KEYBYTES);
    var token = sodium.crypto_auth(buf, key);

    it('check param 1', function(done) {
        var t = "token";
        var b = buf;
        var k = key;

        assert.throws(function() {
            var r = sodium.crypto_auth_verify(t, b, k);
        });

        t = Buffer.allocUnsafe(5);
        assert.throws(function() {
            var r = sodium.crypto_auth_verify(t, b, k);
        });

        t = 5;
        assert.throws(function() {
            var r = sodium.crypto_auth_verify(t, b, k);
        });

        done();
    });

    it('check param 2', function(done) {
        var t = token;
        var b = "buf";
        var k = key;

        assert.throws(function() {
            var r = sodium.crypto_auth_verify(t, b, k);
        });

        b = 5;
        assert.throws(function() {
            var r = sodium.crypto_auth_verify(t, b, k);
        });

        done();
    });

    it('check param 3', function(done) {
        var t = token;
        var b = buf;
        var k = "key";

        assert.throws(function() {
            var r = sodium.crypto_auth_verify(t, b, k);
        });


        k = 5;
        assert.throws(function() {
            var r = sodium.crypto_auth_verify(t, b, k);
        });

        done();
    });

});
