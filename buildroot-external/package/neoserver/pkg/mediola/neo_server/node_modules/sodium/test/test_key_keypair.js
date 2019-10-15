/**
 * Created by bmf on 11/2/13.
 */
var assert = require('assert');
var crypto = require('crypto');

var Key = require('../lib/keys/keypair');
if (process.env.COVERAGE) {
    Key = require('../lib-cov/keys/keypair');
}

describe("KeyPair", function () {
    it('generate should throw', function(done) {
        var key = new Key();
        assert.throws(function() {
            key.init();
        });
        done();
    });

    it('generate should throw', function(done) {
        var key = new Key();
        assert.throws(function() {
            key.generate();
        });
        done();
    });

});