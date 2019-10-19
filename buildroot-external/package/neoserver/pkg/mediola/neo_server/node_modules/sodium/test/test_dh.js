/**
 * Test Group Key Exchanges
 */
var assert = require('assert');
var Sodium = require('../lib/sodium');
if (process.env.COVERAGE) {
	Sodium = require('../lib-cov/sodium');
}

describe('DH Group Key Exchange', function () {
	it('should work for a groupd', function (done) {

		var a = new Sodium.Key.ECDH("", Sodium.Hash.sha256(Buffer.from(
			"9549937362")));
		var b = new Sodium.Key.ECDH("", Sodium.Hash.sha256(Buffer.from(
			"9542584444")));

		var abDH = new Sodium.ECDH(b.pk(), a.sk()).secret();
		var baDH = new Sodium.ECDH(a.pk(), b.sk()).secret();

		assert.deepEqual(abDH,baDH);

		done();
	});
});
