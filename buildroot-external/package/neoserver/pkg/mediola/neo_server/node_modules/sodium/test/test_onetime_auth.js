/**
 * Created by bmf on 11/2/13.
 */
var assert = require('assert');
var sodium = require('../build/Release/sodium');

var Auth = require('../lib/onetime-auth');
if (process.env.COVERAGE) {
    Auth = require('../lib-cov/onetime-auth');
}

describe("Auth", function () {
    it("generate token and validate message", function (done) {
        var auth = new Auth();
        var token = auth.generate("This is a test", 'utf8');

        assert.ok(auth.validate(token, "This is a test", 'utf8'));
        done();
    });

    it("key size should match that of sodium", function (done) {
        var auth = new Auth();
        assert.equal(auth.key().size(), sodium.crypto_auth_KEYBYTES);
        done();
    });

    it("generate return false on a bad token", function (done) {
        var auth = new Auth();
        auth.key().generate();
        var token = auth.generate("This is a test", 'utf8');

        token[0] = 99;
        token[1] = 99;
        token[2] = 99;

        assert.ok(!auth.validate(token, "This is a test", 'utf8'));
        done();
    });

    it("set bad secretKey should fail", function (done) {
        var auth = new Auth();

        assert.throws(function() {
            auth.set(Buffer.allocUnsafe(2));
        });

        done();
    });

    it("set/get secretKey", function (done) {
        var auth = new Auth();

        auth.key().generate();
        var k = auth.key().get();

        var auth2 = new Auth();
        auth2.key().set(k);

        k2 = auth2.key().get();

        assert.deepEqual(k2, k);

        done();
    });

    it('should fail call validate before having a key', function() {
        var auth = new Auth();
        assert.throws(function() {
            auth.validate("123123", "123123");
        });
    });
});
