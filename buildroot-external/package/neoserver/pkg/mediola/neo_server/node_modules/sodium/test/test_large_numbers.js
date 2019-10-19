/**
 * Created by bmf on 03/28/16.
 */
"use strict";

var assert = require('assert');
var sodium = require('../build/Release/sodium');
var assert = require('assert');

describe('LargeNumbers', function() {
    it('should increment a zero filled buffer to 3 after 3 calls', function(done) {
        var buf = Buffer.alloc(10);
        sodium.increment(buf,10);
        sodium.increment(buf,10);
        sodium.increment(buf,10);

        var zeros = 0;
        assert.equal(buf[0], 3);
        for(var i=1; i<buf.length; i++) {
           assert.equal(buf[i], 0);
        }

        done();
    });

    it('should add two buffers of the same size', function(done) {
        var buf1 = Buffer.allocUnsafe(10);
        var buf2 = Buffer.allocUnsafe(10);
        var buf3 = Buffer.alloc(10);

        sodium.randombytes_buf(buf1);
        buf1.copy(buf2);

        var j= sodium.randombytes_uniform(10000);
        for(var i = 0; i < j; i++) {
            sodium.increment(buf1);
            sodium.increment(buf3);
        }

        sodium.add(buf2, buf3, 10);
        assert(sodium.compare(buf1, buf2)==0);
        done();
    });

    it('should throw on buffers of different sizes', function(done) {
        var buf1 = Buffer.allocUnsafe(10);
        var buf2 = Buffer.allocUnsafe(100);

        assert.throws(function() {
            sodium.add(buf1, buf2);
        });

        done();
    });

    it('add should fail on param 1 ont being a buffer', function(done) {
        var buf = Buffer.allocUnsafe(10);
        assert.throws(function() {
            sodium.add("abc", buf);
        });
        done();
    });

    it('add should fail on param 2 ont being a buffer', function(done) {
        var buf = Buffer.allocUnsafe(10);
        assert.throws(function() {
            sodium.add(buf, "abc");
        });
        done();
    });

    it('compare should return true on equal buffers', function(done) {
        var buf1 = Buffer.allocUnsafe(10);
        var buf2 = Buffer.allocUnsafe(10);

        sodium.randombytes_buf(buf1);
        buf1.copy(buf2);

        assert(sodium.compare(buf1, buf2)==0);

        done();
    });

    it('compare should return not return 0 on different buffers', function(done) {
        var buf1 = Buffer.allocUnsafe(10);
        var buf2 = Buffer.allocUnsafe(10);

        sodium.randombytes_buf(buf1);
        sodium.randombytes_buf(buf2);

        assert(sodium.compare(buf1, buf2)!=0);

        done();
    });

    it('compare should throw on different size buffers', function(done) {
        var buf1 = Buffer.allocUnsafe(10);
        var buf2 = Buffer.allocUnsafe(100);

        sodium.randombytes_buf(buf1);
        sodium.randombytes_buf(buf2);

        assert.throws(function() {
            sodium.compare(buf1, buf2);
        });

        done();
    });

    it('is_zero test for 0', function(done) {
        var buf = Buffer.alloc(10);
        assert(sodium.is_zero(buf)==1);
        done();
    });

    it('is_zero test should be false for non zero buffers', function(done) {
        var buf = Buffer.allocUnsafe(10);
        sodium.randombytes_buf(buf);
        assert(sodium.is_zero(buf)==0);
        done();
    });
});
