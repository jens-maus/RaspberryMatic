/**
 * Created by bmf on 11/2/13.
 */
var assert = require('assert');
var sodium = require('../build/Release/sodium');

var ECDH = require('../lib/ecdh');
var DHKey = require('../lib/keys/dh-key');
if (process.env.COVERAGE) {
    ECDH = require('../lib-cov/ecdh');
    DHKey = require('../lib-cov/keys/dh-key');
}

describe("ECDH", function () {
    it("should calculate the same secret", function (done) {
        var bob = new DHKey();
        var alice = new DHKey();

        var aliceDH = new ECDH(bob.pk().get(), alice.sk().get());
        var bobDH = new ECDH(alice.pk().get(), bob.sk().get());

        var bobSecret = bobDH.secret();
        var aliceSecret = aliceDH.secret();

        assert.deepEqual(bobSecret,aliceSecret);
        done();
    });

    it("should calculate the same session key", function (done) {
        var bob = new DHKey();
        var alice = new DHKey();

        var aliceDH = new ECDH(bob.pk().get(), alice.sk().get());
        var bobDH = new ECDH(alice.pk().get(), bob.sk().get());

        var bobSecret = bobDH.sessionKey();
        var aliceSecret = aliceDH.sessionKey();

        assert.deepEqual(bobSecret, aliceSecret);
        done();
    });
});