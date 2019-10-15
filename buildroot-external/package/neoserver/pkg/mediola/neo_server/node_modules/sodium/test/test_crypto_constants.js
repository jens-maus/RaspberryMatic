/**
 * Created by bmf on 10/31/13.
 */
"use strict";

var assert = require('assert');
var sodium = require('../build/Release/sodium');

function checkBiggerThanZero(n) {
    assert.equal(typeof n, 'number');
    assert.ok(n > 0);
}

describe('Constants', function() {
    it('should define lib constants', function(done) {
        checkBiggerThanZero(sodium.crypto_auth_BYTES);
        checkBiggerThanZero(sodium.crypto_auth_KEYBYTES);
        checkBiggerThanZero(sodium.crypto_box_NONCEBYTES);
        checkBiggerThanZero(sodium.crypto_box_BEFORENMBYTES);
        checkBiggerThanZero(sodium.crypto_box_BOXZEROBYTES);
        checkBiggerThanZero(sodium.crypto_box_PUBLICKEYBYTES);
        checkBiggerThanZero(sodium.crypto_box_SECRETKEYBYTES);
        checkBiggerThanZero(sodium.crypto_box_ZEROBYTES);
        checkBiggerThanZero(sodium.crypto_hash_BYTES);
        checkBiggerThanZero(sodium.crypto_onetimeauth_BYTES);
        checkBiggerThanZero(sodium.crypto_onetimeauth_KEYBYTES);
        checkBiggerThanZero(sodium.crypto_secretbox_BOXZEROBYTES);
        checkBiggerThanZero(sodium.crypto_secretbox_KEYBYTES);
        checkBiggerThanZero(sodium.crypto_secretbox_NONCEBYTES);
        checkBiggerThanZero(sodium.crypto_secretbox_ZEROBYTES);
        checkBiggerThanZero(sodium.crypto_sign_BYTES);
        checkBiggerThanZero(sodium.crypto_sign_PUBLICKEYBYTES);
        checkBiggerThanZero(sodium.crypto_sign_SECRETKEYBYTES);
        checkBiggerThanZero(sodium.crypto_stream_KEYBYTES);
        checkBiggerThanZero(sodium.crypto_stream_NONCEBYTES);
        done();
    });

    it('should fail to assign crypto_stream_NONCEBYTES', function(done) {
         assert.throws(function() {
            sodium.crypto_stream_NONCEBYTES = 0;
        });
        done();
    });

    it('should fail to assign crypto_stream_KEYBYTES', function(done) {
         assert.throws(function() {
            sodium.crypto_stream_KEYBYTES = 0;
        });
        done();
    });

    it('should fail to assign crypto_sign_SECRETKEYBYTES', function(done) {
         assert.throws(function() {
            sodium.crypto_sign_SECRETKEYBYTES = 0;
        });
        done();
    });

    it('should fail to assign crypto_sign_PUBLICKEYBYTES', function(done) {
         assert.throws(function() {
            sodium.crypto_sign_PUBLICKEYBYTES = 0;
        });
        done();
    });

    it('should fail to assign crypto_sign_BYTES', function(done) {
         assert.throws(function() {
            sodium.crypto_sign_BYTES = 0;
        });
        done();
    });

    it('should fail to assign crypto_secretbox_ZEROBYTES', function(done) {
         assert.throws(function() {
            sodium.crypto_secretbox_ZEROBYTES = 0;
        });
        done();
    });

    it('should fail to assign crypto_secretbox_NONCEBYTES', function(done) {
         assert.throws(function() {
            sodium.crypto_secretbox_NONCEBYTES = 0;
        });
        done();
    });

    it('should fail to assign crypto_secretbox_KEYBYTES', function(done) {
         assert.throws(function() {
            sodium.crypto_secretbox_KEYBYTES = 0;
        });
        done();
    });

    it('should fail to assign crypto_onetimeauth_KEYBYTES', function(done) {
         assert.throws(function() {
            sodium.crypto_onetimeauth_KEYBYTES = 0;
        });
        done();
    });

    it('should fail to assign crypto_secretbox_BOXZEROBYTES', function(done) {
         assert.throws(function() {
            sodium.crypto_secretbox_BOXZEROBYTES = 0;
        });
        done();
    });

    it('should fail to assign crypto_onetimeauth_BYTES', function(done) {
         assert.throws(function() {
            sodium.crypto_onetimeauth_BYTES = 0;
        });
        done();
    });

    it('should fail to assign crypto_hash_BYTES', function(done) {
         assert.throws(function() {
            sodium.crypto_hash_BYTES = 0;
        });
        done();
    });

    it('should fail to assign crypto_box_ZEROBYTES', function(done) {
         assert.throws(function() {
            sodium.crypto_box_ZEROBYTES = 0;
        });
        done();
    });

    it('should fail to assign crypto_box_SECRETKEYBYTES', function(done) {
         assert.throws(function() {
            sodium.crypto_box_SECRETKEYBYTES = 0;
        });
        done();
    });

    it('should fail to assign crypto_box_PUBLICKEYBYTES', function(done) {
         assert.throws(function() {
            sodium.crypto_box_PUBLICKEYBYTES = 0;
        });
        done();
    });

    it('should fail to assign crypto_box_BOXZEROBYTES', function(done) {
         assert.throws(function() {
            sodium.crypto_box_BOXZEROBYTES = 0;
        });
        done();
    });

    it('should fail to assign crypto_box_BEFORENMBYTES', function(done) {
         assert.throws(function() {
            sodium.crypto_box_BEFORENMBYTES = 0;
        });
        done();
    });

    it('should fail to assign crypto_auth_KEYBYTES', function(done) {
         assert.throws(function() {
            sodium.crypto_auth_KEYBYTES = 0;
        });
        done();
    });

    it('should fail to assign crypto_box_NONCEBYTES', function(done) {
         assert.throws(function() {
            sodium.crypto_box_NONCEBYTES = 0;
        });
        done();
    });

    it('should fail to assign crypto_auth_BYTES', function(done) {
         assert.throws(function() {
            sodium.crypto_auth_BYTES = 0;
        });
        done();
    });
});
