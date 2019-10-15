/**
 * Created by bmf on 10/31/13.
 */
"use strict";

var assert = require('assert');
var sodium = require('../build/Release/sodium');

describe('Utils', function() {
    it('should zero a buffer', function(done) {
        var buf = Buffer.alloc(100, 1);
        sodium.memzero(buf);
        for(var i=0; i< buf.length; i++) {
            assert.equal(buf[i],0);
        }
        done();
    });
});

describe("memzero verify parameters", function () {
    var buf = Buffer.allocUnsafe(100);
    it('bad param 1 string', function(done) {
        buf = "token";
        assert.throws(function() {
            sodium.memzero(buf);
        });
        done();
    });
    it('bad param 1 number', function(done) {
        buf = 123;
        assert.throws(function() {
            sodium.memzero(buf);
        });
        done();
    });
});
