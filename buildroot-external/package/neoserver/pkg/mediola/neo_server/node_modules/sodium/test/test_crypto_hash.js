/**
 * Created by bmf on 10/31/13.
 */
"use strict";

var assert = require('assert');
var sodium = require('../build/Release/sodium');
var crypto = require('crypto');

describe('Hash', function() {
    it('should return sha hash', function(done) {
        var buf = Buffer.alloc(100, 1);
        var r = sodium.crypto_hash(buf);
        var hashString = r.toString('hex');
        assert.equal(hashString, "ceacfdb0944ac37da84556adaac97bbc9a0190ae8ca091576b91ca70e134d1067da2dd5cc311ef147b51adcfbfc2d4086560e7af1f580db8bdc961d5d7a1f127");
        assert.equal(hashString, crypto.createHash('sha512').update(buf).digest('hex'));
        done();
    });

    it('should calculate same hash as the crypto module', function(done) {
        var buf = Buffer.alloc(100, 1);
        var r = sodium.crypto_hash(buf);
        var hashString = r.toString('hex');
        assert.equal(hashString, crypto.createHash('sha512').update(buf).digest('hex'));
        done();
    });

    it('should return sha512', function(done) {
        var buf = Buffer.alloc(100, 1);
        var r = sodium.crypto_hash_sha512(buf);
        var hashString = r.toString('hex');
        assert.equal(hashString, "ceacfdb0944ac37da84556adaac97bbc9a0190ae8ca091576b91ca70e134d1067da2dd5cc311ef147b51adcfbfc2d4086560e7af1f580db8bdc961d5d7a1f127");
        done();
    });

    it('should calculate same hash as the crypto module', function(done) {
        var buf = Buffer.alloc(100, 1);
        var r = sodium.crypto_hash_sha256(buf);
        var hashString = r.toString('hex');
        assert.equal(hashString, crypto.createHash('sha256').update(buf).digest('hex'));
        done();
    });
});

describe('crypto_hash_sha512 verify parameters', function() {
    it('bad param 1', function(done) {
         assert.throws(function() {
            var r = sodium.crypto_hash_sha512("buf");
        });

         assert.throws(function() {
            var r = sodium.crypto_hash_sha512(1);
        });
        done();
    });
});

describe('crypto_hash_sha verify parameters', function() {
    it('bad param 1', function(done) {
         assert.throws(function() {
            var r = sodium.crypto_hash_sha("buf");
        });

         assert.throws(function() {
            var r = sodium.crypto_hash_sha(1);
        });
        done();
    });
});

describe('crypto_hash_sha256 verify parameters', function() {
    it('bad param 1', function(done) {
         assert.throws(function() {
            var r = sodium.crypto_hash_sha256("buf");
        });

         assert.throws(function() {
            var r = sodium.crypto_hash_sha256(1);
        });
        done();
    });
});
