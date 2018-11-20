/**
 * Created by bmf on 11/2/13.
 */
var assert = require('assert');
var sodium = require('../build/Release/sodium');

var Sign = require('../lib/sign');
var SignKey = require('../lib/keys/sign-key');
if (process.env.COVERAGE) {
    Sign = require('../lib-cov/sign');
    SignKey = require('../lib-cov/keys/sign-key');
}

describe("Sign", function () {
    it("sign/verify message", function (done) {
        var sign = new Sign();
        var message = Buffer.from("This is a test", 'utf8');
        var signedMsg = sign.sign("This is a test", 'utf8');
        var checkMsg = Sign.verify(signedMsg);
        assert.equal(checkMsg.toString('utf8'),"This is a test");
        done();
    });
    it("sign/verify with existing key", function(done) {
        var key = new SignKey(
            'DsWygyoTcB7/NT5OqRzT0eaFf+6bJBSSBRfDOyU3x9k=',
            'Aav6yqemxoPNNqxeKJXMlruKxXEHLD931S8pXzxt4mkO' +
            'xbKDKhNwHv81Pk6pHNPR5oV/7pskFJIFF8M7JTfH2Q==',
            'base64');
        var sign = new Sign(key);
        var message = Buffer.from("This is a test", 'utf8');
        var signedMsg = sign.sign("This is a test", 'utf8');
        assert.equal(signedMsg.publicKey.toString('base64'),
            'DsWygyoTcB7/NT5OqRzT0eaFf+6bJBSSBRfDOyU3x9k=');
        var checkMsg = Sign.verify(signedMsg);
        assert.equal(checkMsg.toString('utf8'), "This is a test");
        done();
    });
    it("sign/verify with key from seed", function(done) {
        var key = new SignKey.fromSeed('Aav6yqemxoPNNqxeKJXMlruKxXEHLD931S8pXzxt4mk=', 'base64');
        var sign = new Sign(key);
        var message = Buffer.from("This is a test", 'utf8');
        var signedMsg = sign.sign("This is a test", 'utf8');
        assert.equal(signedMsg.publicKey.toString('base64'),
            'DsWygyoTcB7/NT5OqRzT0eaFf+6bJBSSBRfDOyU3x9k=');
        var checkMsg = Sign.verify(signedMsg);
        assert.equal(checkMsg.toString('utf8'), "This is a test");
        done();
    });
});
