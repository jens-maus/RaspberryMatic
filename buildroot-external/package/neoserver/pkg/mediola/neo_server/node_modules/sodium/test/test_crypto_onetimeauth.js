/**
 * Created by bmf on 10/31/13.
 */
"use strict";

var assert = require('assert');
var crypto = require('crypto');
var sodium = require('../build/Release/sodium');

describe('OneTimeAuth', function() {
    it('should validate', function(done) {
        var buf = crypto.randomBytes(256);
        var key = crypto.randomBytes(sodium.crypto_auth_KEYBYTES);
        var token = sodium.crypto_onetimeauth(buf, key);
        var r = sodium.crypto_onetimeauth_verify(token, buf, key);
        assert.equal(r, 0);
        done();
    });
});

describe('crypto_onetimeauth verify parameters', function() {
    var buf = crypto.randomBytes(256);
    var key = crypto.randomBytes(sodium.crypto_auth_KEYBYTES);

    it('bad param 1 string', function(done) {
        buf = "123";
         assert.throws(function() {
            var token = sodium.crypto_onetimeauth(buf, key);
        });
        done();
    });

    it('bad param 1 number', function(done) {
        buf = 123;
         assert.throws(function() {
            var token = sodium.crypto_onetimeauth(buf, key);
        });
        done();
    });

    it('bad param 2 string', function(done) {
        key = "123";
        assert.throws(function() {
            var token = sodium.crypto_onetimeauth(buf, key);
        });
        done();
    });

    it('bad param 2 buffer', function(done) {
        key = Buffer.allocUnsafe(2);
        assert.throws(function() {
            var token = sodium.crypto_onetimeauth(buf, key);
        });
        done();
    });

    it('bad param 2 number', function(done) {
        key = 123;
         assert.throws(function() {
            var token = sodium.crypto_onetimeauth(buf, key);
        });
        done();
    });
});

describe('crypto_onetimeauth_verify verify parameters', function() {
    var buf = crypto.randomBytes(256);
    var key = crypto.randomBytes(sodium.crypto_auth_KEYBYTES);
    var token = sodium.crypto_onetimeauth(buf, key);

    it('bad param 1 string', function(done) {
        token = "token";
        assert.throws(function() {
            var r = sodium.crypto_onetimeauth_verify(token, buf, key);
        });
        done();
    });

    it('bad param 1 small buffer', function(done) {
        token = Buffer.allocUnsafe(2);
        assert.throws(function() {
            var r = sodium.crypto_onetimeauth_verify(token, buf, key);
        });
        done();
    });

    it('bad param 1 small number', function(done) {
        token = 2;
         assert.throws(function() {
            var r = sodium.crypto_onetimeauth_verify(token, buf, key);
        });
        done();
    });

    it('bad param 2 string', function(done) {
        buf = "qweqw";
         assert.throws(function() {
            var r = sodium.crypto_onetimeauth_verify(token, buf, key);
        });
        done();
    });

    it('bad param 2 small number', function(done) {
        buf = 1;
         assert.throws(function() {
            var r = sodium.crypto_onetimeauth_verify(token, buf, key);
        });
        done();
    });

    it('bad param 3 string', function(done) {
        key = "qweqw";
         assert.throws(function() {
            var r = sodium.crypto_onetimeauth_verify(token, buf, key);
        });
        done();
    });

    it('bad param 3 buffer', function(done) {
        key = Buffer.allocUnsafe(2);
         assert.throws(function() {
            var r = sodium.crypto_onetimeauth_verify(token, buf, key);
        });
        done();
    });

    it('bad param 3 small number', function(done) {
        key = 1;
         assert.throws(function() {
            var r = sodium.crypto_onetimeauth_verify(token, buf, key);
        });
        done();
    });
});
