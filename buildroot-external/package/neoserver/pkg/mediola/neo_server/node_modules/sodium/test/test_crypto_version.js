/**
 * Created by bmf on 10/31/13.
 */
"use strict";

var assert = require('assert');
var sodium = require('../build/Release/sodium');

describe('Version', function() {
    it('should return a string', function(done) {
        var v = sodium.sodium_version_string();
        assert.equal(typeof v,'string');
        done();
    })

    it('Minor should return an integer', function(done) {
        assert.equal(typeof sodium.sodium_library_version_minor(),'number');
        done();
    });

    it('Major should return an integer', function(done) {
        assert.equal(typeof sodium.sodium_library_version_major(),'number');
        done();
    });
});
