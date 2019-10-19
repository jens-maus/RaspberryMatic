/**
 * Created by bmf on 10/31/13.
 */
"use strict";

var assert = require('assert');
var crypto = require('crypto');
var sodium = require('../build/Release/sodium');
var toBuffer = require('../lib/toBuffer');

var key = Buffer.allocUnsafe(sodium.crypto_auth_KEYBYTES)
key.fill('Jefe');
key.fill(0,4,32);
var c = toBuffer('what do ya want for nothing?', 'ascii');

var key2 = toBuffer('Another one got caught today, it\'s all over the papers. "Teenager Arrested in Computer Crime Scandal", "Hacker Arrested after Bank Tampering"... Damn kids. They\'re all alike.', 'ascii');

var expected1 = toBuffer(
    [ 0x16, 0x4b, 0x7a, 0x7b, 0xfc, 0xf8, 0x19, 0xe2,
      0xe3, 0x95, 0xfb, 0xe7, 0x3b, 0x56, 0xe0, 0xa3,
      0x87, 0xbd, 0x64, 0x22, 0x2e, 0x83, 0x1f, 0xd6,
      0x10, 0x27, 0x0c, 0xd7, 0xea, 0x25, 0x05, 0x54 ]);

var expected2 = toBuffer(
    [ 0x7b, 0x9d, 0x83, 0x38, 0xeb, 0x1e, 0x3d, 0xdd,
      0xba, 0x8a, 0x9a, 0x35, 0x08, 0xd0, 0x34, 0xa1,
      0xec, 0xbe, 0x75, 0x11, 0x37, 0xfa, 0x1b, 0xcb,
      0xa0, 0xf9, 0x2a, 0x3e, 0x6d, 0xfc, 0x79, 0x80,
      0xb8, 0x81, 0xa8, 0x64, 0x5f, 0x92, 0x67, 0x22,
      0x74, 0x37, 0x96, 0x4b, 0xf3, 0x07, 0x0b, 0xe2,
      0xb3, 0x36, 0xb3, 0xa3, 0x20, 0xf8, 0x25, 0xce,
      0xc9, 0x87, 0x2d, 0xb2, 0x50, 0x4b, 0xf3, 0x6d ]);

var expected3 = toBuffer(
    [ 0x73, 0xe0, 0x0d, 0xcb, 0xf4, 0xf8, 0xa3, 0x33,
      0x30, 0xac, 0x52, 0xed, 0x2c, 0xc9, 0xd1, 0xb2,
      0xef, 0xb1, 0x77, 0x13, 0xd3, 0xec, 0xe3, 0x96,
      0x14, 0x9f, 0x37, 0x65, 0x3c, 0xfe, 0x70, 0xe7,
      0x1f, 0x2c, 0x6f, 0x9a, 0x62, 0xc3, 0xc5, 0x3a,
      0x31, 0x8a, 0x9a, 0x0b, 0x3b, 0x78, 0x60, 0xa4,
      0x31, 0x6f, 0x72, 0x9b, 0x8d, 0x30, 0x0f, 0x15,
      0x9b, 0x2f, 0x60, 0x93, 0xa8, 0x60, 0xc1, 0xed ]);

var a = Buffer.allocUnsafe(sodium.crypto_auth_BYTES);
var a2 = Buffer.allocUnsafe(sodium.crypto_auth_hmacsha512_BYTES);

describe('LibSodium Auth', function() {
    it('crypto_auth should return the expected auth token', function(done) {
        var authToken = sodium.crypto_auth(c, key);
        assert.deepEqual(authToken, expected1);
        assert.equal(authToken.length, sodium.crypto_auth_BYTES);
        done();
    });

    it('crypto_auth_hmacsha512_* = crypto_auth_hmacsha512', function(done) {
        // Split the message in half
        var halfLength = Math.ceil(c.length / 2);

        var c1 = c.slice(0, halfLength);
        var c2 = c.slice(halfLength, c.length);

        var s1 = sodium.crypto_auth_hmacsha512_init(key);
        var s2 = sodium.crypto_auth_hmacsha512_update(s1, c1);
        var s3 = sodium.crypto_auth_hmacsha512_update(s2, c2);
        var a1 = sodium.crypto_auth_hmacsha512_final(s3);

        var a2 = sodium.crypto_auth_hmacsha512(c, key);

        // Assert that the states changed with each update
        assert.notDeepEqual(s1, s2);
        assert.notDeepEqual(s2, s3);
        assert.notDeepEqual(s1, s3);

        // Assert that it matches what we expected
        assert.deepEqual(a1, a2);

        // Is it the right token length
        assert.equal(a1.length, sodium.crypto_auth_hmacsha512_BYTES);
        assert.equal(a2.length, sodium.crypto_auth_hmacsha512_BYTES);
        done();
    });

/* THIS TEST IS DISABLED DUE TO A LIBSODIUM BUG
    it('crypto_auth_hmacsha512_* = crypto_auth_hmacsha512', function(done) {
        // Split the message in half
        var c1 = c.slice(0, 1);
        var c2 = c.slice(0, c.length -1);

        var s1 = sodium.crypto_auth_hmacsha512_init(key2);
        var s2 = sodium.crypto_auth_hmacsha512_update(s1, c1);
        var s3 = sodium.crypto_auth_hmacsha512_update(s2, c2);
        var a1 = sodium.crypto_auth_hmacsha512_final(s3);

        // Assert that the states changed with each update
        assert.notDeepEqual(s1, s2);
        assert.notDeepEqual(s2, s3);
        assert.notDeepEqual(s1, s3);

        // Assert that it matches what we expected
        assert.deepEqual(a1, expected2);

        // Is it the right token length
        assert.equal(a1.length, sodium.crypto_auth_hmacsha512_BYTES);
        done();
    });
*/
});
