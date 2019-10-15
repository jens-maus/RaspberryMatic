/**
 * Created by bmf on 10/31/13.
 */
"use strict";

var assert = require('assert');
var crypto = require('crypto');
var sodium = require('../build/Release/sodium');
var toBuffer = require('../lib/toBuffer');

var key = Buffer.allocUnsafe(sodium.crypto_auth_KEYBYTES);
key.fill('Jefe');
key.fill(0, 4, 32);
var c = toBuffer('what do ya want for nothing?', 'ascii');

var key2 = toBuffer('Another one got caught today, it\'s all over the papers. "Teenager Arrested in Computer Crime Scandal", "Hacker Arrested after Bank Tampering"... Damn kids. They\'re all alike.', 'ascii');

testAlgorithm('hmacsha256', key);
testAlgorithm('hmacsha512', key);
testAlgorithm('hmacsha512256', key);

/* TESTS DISABLED DUE TO LIBSODIUM BUG.
testAlgorithm('hmacsha256', key2);
testAlgorithm('hmacsha512', key2);
testAlgorithm('hmacsha512256', key2);
*/

function testAlgorithm(algo, k) {
    // Split the message in half
    var halfLength = Math.ceil(c.length / 2);
    var c1 = c.slice(0, halfLength);
    var c2 = c.slice(halfLength, c.length);

    // Stream API
    var s1 = sodium['crypto_auth_' + algo + '_init'](k);
    var s2 = sodium['crypto_auth_' + algo + '_update'](s1, c1);
    var s3 = sodium['crypto_auth_' + algo + '_update'](s2, c2);
    var a1 = sodium['crypto_auth_' + algo + '_final'](s3);

    // Regular API
    var a2 = sodium['crypto_auth_' + algo](c, k);

    describe('LibSodium Auth, with key length ' + k.length, function() {
        it('Streamming API state is updating', function(done){
            // Assert that the states changed with each update
            assert.notDeepEqual(s1, s2);
            assert.notDeepEqual(s2, s3);
            assert.notDeepEqual(s1, s3);
            done();
        });

        it('Stream API must produce same results as regular API ' + algo, function(done) {
            // Assert that streamming API produces the same result as regular API
            assert(sodium.compare(a1, a2)==0, "Stream differs from Regular API" );
            done();
        });

        it('Token lengths must be what we expect for ' + algo, function(done) {
            // Is it the right token length
            assert.equal(a1.length, sodium['crypto_auth_' + algo + '_BYTES']);
            assert.equal(a2.length, sodium['crypto_auth_' + algo + '_BYTES']);
            done();
        });

        it('must verify auth token ' + algo, function(done) {
            assert.equal(sodium['crypto_auth_' + algo + '_verify'](a1, c, k), 0);
            assert.equal(sodium['crypto_auth_' + algo + '_verify'](a2, c, k), 0);
            done();
        });
    });
}
