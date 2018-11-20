/**
 * Created by bmf on 10/31/13.
 */
"use strict";

var assert = require('assert');
var sodium = require('../build/Release/sodium');

describe('String Comparison', function() {
    it('crypto_verify_16 throw with strings smaller than 16 bytes', function(done) {
        var string1 = Buffer.from("1234", "ascii");
        var string2 = Buffer.from("1234", "ascii");
         assert.throws(function() {
            var r = sodium.crypto_verify_16(string1, string2);
        });
        done();
    });

    it('crypto_verify_16 should return 0 when strings are equal', function(done) {
        var string1 = Buffer.from("0123456789ABCDEF", "ascii");
        var string2 = Buffer.from("0123456789ABCDEF", "ascii");
        var r = sodium.crypto_verify_16(string1, string2);
        assert.equal(r, 0);
        done();
    });

    it('crypto_verify_16 should return -1 when strings are different', function(done) {
        var string1 = Buffer.from("0123456789ABCDEF", "ascii");
        var string2 = Buffer.from("0023456789ABCDEF", "ascii");
        var r = sodium.crypto_verify_16(string1, string2);
        assert.equal(r, -1);
        done();
    });

    it('crypto_verify_32 throw with strings smaller than 32 bytes', function(done) {
        var string1 = Buffer.from("1234", "ascii");
        var string2 = Buffer.from("1234", "ascii");
         assert.throws(function() {
            var r = sodium.crypto_verify_32(string1, string2);
        });
        done();
    });

    it('crypto_verify_32 should return 0 when strings are equal', function(done) {
        var string1 = Buffer.from("0123456789ABCDEF0123456789ABCDEF", "ascii");
        var string2 = Buffer.from("0123456789ABCDEF0123456789ABCDEF", "ascii");
        var r = sodium.crypto_verify_32(string1, string2);
        assert.equal(r, 0);
        done();
    });

    it('crypto_verify_32 return -1 when strings are different', function(done) {
        var string1 = Buffer.from("0123456789ABCDEF0123456789ABCDEF", "ascii");
        var string2 = Buffer.from("0023456789ABCDEF0123456789ABCDEF", "ascii");
        var r = sodium.crypto_verify_32(string1, string2);
        assert.equal(r, -1);
        done();
    });
});

describe("crypto_verify_32 verify parameters", function () {
    var string1 = Buffer.from("0123456789ABCDEF0123456789ABCDEF", "ascii");
    var string2 = Buffer.from("0123456789ABCDEF0123456789ABCDEF", "ascii");

    it('bad param 1 string', function(done) {
        string1 = "123";
         assert.throws(function() {
            var r = sodium.crypto_verify_32(string1, string2);
        });
        done();
    });

    it('bad param 1 number', function(done) {
        string1 = 123;
         assert.throws(function() {
            var r = sodium.crypto_verify_32(string1, string2);
        });
        done();
    });

    it('bad param 2 string', function(done) {
        string2 = "123";
         assert.throws(function() {
            var r = sodium.crypto_verify_32(string1, string2);
        });
        done();
    });

    it('bad param 2 number', function(done) {
        string2 = 123;
         assert.throws(function() {
            var r = sodium.crypto_verify_32(string1, string2);
        });
        done();
    });
});

describe("crypto_verify_16 verify parameters", function () {
    var string1 = Buffer.from("0123456789ABCDEF0123456789ABCDEF", "ascii");
    var string2 = Buffer.from("0123456789ABCDEF0123456789ABCDEF", "ascii");

    it('bad param 1 string', function(done) {
        string1 = "123";
         assert.throws(function() {
            var r = sodium.crypto_verify_16(string1, string2);
        });
        done();
    });

    it('bad param 1 number', function(done) {
        string1 = 123;
         assert.throws(function() {
            var r = sodium.crypto_verify_16(string1, string2);
        });
        done();
    });

    it('bad param 2 string', function(done) {
        string2 = "123";
         assert.throws(function() {
            var r = sodium.crypto_verify_16(string1, string2);
        });
        done();
    });

    it('bad param 2 number', function(done) {
        string2 = 123;
         assert.throws(function() {
            var r = sodium.crypto_verify_16(string1, string2);
        });
        done();
    });
});
