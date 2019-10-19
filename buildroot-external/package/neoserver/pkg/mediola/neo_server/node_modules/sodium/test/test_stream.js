/**
 * Created by bmf on 11/2/13.
 */
var assert = require('assert');
var sodium = require('../build/Release/sodium');

var Stream = require('../lib/stream');
if (process.env.COVERAGE) {
    Stream = require('../lib-cov/stream');
}

describe("Stream", function () {
    it("encryp/decrypt message", function (done) {
        var stream = new Stream();

        var cTxt = stream.encrypt("This is a test", "utf8");
        var checkMsg = stream.decrypt(cTxt);
        assert.equal(checkMsg.toString('utf8'), "This is a test");
        done();
    });

    it("should return a stream buffer", function (done) {
        var stream = new Stream();

        var s = stream.generate(100);
        assert.equal(typeof s, 'object');
        assert.notEqual(typeof s.stream, 'undefined');
        assert.notEqual(typeof s.nonce, 'undefined');
        //assert.equal(s.stream.length, 100);
        //assert.equal(s.nonce.length, sodium.crypto_stream_NONCEBYTES);
        done();
    });

});