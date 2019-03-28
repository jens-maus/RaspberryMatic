/**
 * Created by bmf on 11/2/13.
 */
var assert = require('assert');
var CryptoBaseBuffer = require('../lib/crypto-base-buffer');
if (process.env.COVERAGE) {
    CryptoBaseBuffer = require('../lib-cov/crypto-base-buffer');
}

describe("CryptoBaseBuffer", function () {

    it('generate should throw', function(done) {
        var cb = new CryptoBaseBuffer();
        assert.throws(function() {
            cb.generate();
        });
        done();
    });

    it('toString should throw', function(done) {
        var cb = new CryptoBaseBuffer();
        assert.throws(function() {
            cb.toString();
        });
        done();
    });

    it('isValid should throw', function(done) {
        var cb = new CryptoBaseBuffer();
        assert.throws(function() {
            cb.isValid();
        });
        done();
    });

});

describe("cb.toBuffer", function () {
    var cb = new CryptoBaseBuffer();

    it("should throw on utf8", function (done) {
        var str = "to buffer is cool";
        assert.throws(function() {
            cb.toBuffer(str, 'utf8').toString().should.eql("to buffer is cool");
        });
        done();
    });

    it("should retun on empty encoding list", function (done) {
        cb.setValidEncodings();
        done();
    });

    it("should return de default encoding", function (done) {
        cb.setEncoding('hex');
        var e = cb.getEncoding();
        assert.equal(e, 'hex');
        done();
    });

    it("should throw on utf8 encoding", function (done) {
        assert.throws(function() {
            cb.setValidEncodings(['hex', 'utf8']);
        });
        done();
    });


    it("should generate a buffer from string with encoding", function (done) {
        var str = "8b166e947343b514c621ac7cfd53b11a9d5c374f507bf102a71b415a5d9e399853d1dc82362d48f47eb1c63889c5ef695ae55793064da563b4d3b26aec64d3e3";
        assert.equal(cb.toBuffer(str, 'hex').toString('hex'), str);
        done();
    });

    it("should return undefined on bad param 1", function (done) {
        assert.throws(function() {
            var b = cb.toBuffer(123, 'utf8');
        });
        done();

    });

    it("should throw on bad encoding", function (done) {
        var str = "to buffer is cool";
        assert.throws(function() {
            cb.toBuffer(str, 'txf');
        });
        done();
    });

    it("should generate a buffer from array", function (done) {
        var a = [1, 2, 3, 4, 5];
        var b = cb.toBuffer(a);
        for( var i = 0 ; i < b.length; i++ ) {
            assert.equal(b[i], a[i]);
        }
        done();
    });

    it("Generate a buffer from buffer!", function (done) {
        var a = Buffer.alloc(5, 5);
        var b = cb.toBuffer(a);
        for( var i = 0 ; i < b.length; i++ ) {
            assert.equal(b[i], a[i]);
        }
        done();
    });


});
