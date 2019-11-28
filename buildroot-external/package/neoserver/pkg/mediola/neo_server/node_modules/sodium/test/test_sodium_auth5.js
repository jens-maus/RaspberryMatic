/**
 * Created by bmf on 07/25/16.
 */
var assert = require('assert');
var sodium = require('../build/Release/sodium');

describe("Auth5", function() {
    var key = Buffer.alloc(32);

    it("Test random vectors", function(done) {
        for (var clen = 0; clen < 1000; ++clen) {
            sodium.randombytes_buf(key);
            c = Buffer.allocUnsafe(clen);
            sodium.randombytes_buf(c);
            var a = sodium.crypto_auth(c, key);
            assert.equal(sodium.crypto_auth_verify(a, c, key), 0);

            if( clen>0) {
                c[sodium.randombytes_uniform(clen)] += 1 + (sodium.randombytes_uniform(255));
                assert.notEqual(sodium.crypto_auth_verify(a, c, key), 0);

                a[sodium.randombytes_uniform(a.length)] += 1 + (sodium.randombytes_uniform(255));
                assert.notEqual(sodium.crypto_auth_verify(a, c, key), 0);
            }
        }
        done();
    });
});
