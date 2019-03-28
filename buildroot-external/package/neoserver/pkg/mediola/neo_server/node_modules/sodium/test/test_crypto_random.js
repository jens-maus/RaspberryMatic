/**
 * Created by bmf on 10/31/13.
 */
"use strict";

var assert = require('assert');
var sodium = require('../build/Release/sodium');

describe('Randombytes', function() {
    it('should return a buffer of random numbers', function(done) {
        var buf = Buffer.alloc(100);
        sodium.randombytes_buf(buf);

        var zeros = 0;
        for(var i=0; i<buf.length; i++) {
            if(!buf[i]) {
                zeros++;
            }
        }

        // If buf is all zeros then randombytes did not work!
        assert.notEqual(zeros, buf.length);
        done();
    });

    it('random should generate a new number', function(done) {
        // Stir the pot and generate a new seed
        sodium.randombytes_stir();
        var r = sodium.randombytes_random() >>> 0;
        assert.equal(typeof r, 'number');
        assert.ok(r > 0);
        done();
    });

    it('uniform should generate a new number', function(done) {
        // Stir the pot and generate a new seed
        sodium.randombytes_stir();
        var r = sodium.randombytes_uniform(100) >>> 0;
        assert.equal(typeof r, 'number');
        assert.ok(r >= 0 && r <= 100);
        done();
    });

    it('should close file descriptor', function(done) {
        // Stir the pot and generate a new seed
        sodium.randombytes_stir();
        sodium.randombytes_close();
        done();
    });
});

describe("randombytes_buf verify parameters", function () {
    var buf = Buffer.allocUnsafe(100);

    it('bad param 1 string', function(done) {
        buf = "token";
         assert.throws(function() {
            sodium.randombytes_buf(buf);
        });
        done();
    });

    it('bad param 1 small number', function(done) {
        buf = 2;
         assert.throws(function() {
            sodium.randombytes_buf(buf);
        });
        done();
    });
});
