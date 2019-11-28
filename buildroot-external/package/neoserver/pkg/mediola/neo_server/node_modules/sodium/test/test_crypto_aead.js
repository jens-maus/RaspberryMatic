var assert = require('assert');
var sodium = require('../build/Release/sodium');
var assert = require('assert');

describe("AEAD", function () {
    it("aes256gcm should encrypt and decrypt to the same string", function (done) {
        var message = Buffer.from("This is a plain text message");
        var additionalData = Buffer.from("this is metadata");

        var nonce = Buffer.allocUnsafe(sodium.crypto_aead_aes256gcm_NPUBBYTES);
        sodium.randombytes_buf(nonce);

        var key = Buffer.allocUnsafe(sodium.crypto_aead_aes256gcm_KEYBYTES);
        sodium.randombytes_buf(key);

        // If CPU does not support AES256gcm don't test
        if( !sodium.crypto_aead_aes256gcm_is_available() ) {
            console.log('AES 256 gcm not supported by CPU');
            done();
            return;
        }

        // Encrypt data
        var cipherText = sodium.crypto_aead_aes256gcm_encrypt(message, additionalData, nonce, key);

        // Decrypt Data
        var plainText = sodium.crypto_aead_aes256gcm_decrypt(cipherText, additionalData, nonce, key);

        // Test equality
        assert(sodium.compare(plainText, message)==0);
        done();
    });



    it("aes256gcm should encrypt and decrypt to the same string with null additional data", function (done) {
        var message = Buffer.from("This is a plain text message");
        var additionalData = Buffer.from("this is metadata");

        var nonce = Buffer.allocUnsafe(sodium.crypto_aead_aes256gcm_NPUBBYTES);
        sodium.randombytes_buf(nonce);

        var key = Buffer.allocUnsafe(sodium.crypto_aead_aes256gcm_KEYBYTES);
        sodium.randombytes_buf(key);

        // If CPU does not support AES256gcm don't test
        if( !sodium.crypto_aead_aes256gcm_is_available() ) {
            console.log('AES 256 gcm not supported by CPU');
            done();
            return;
        }

        // Encrypt data
        var cipherText = sodium.crypto_aead_aes256gcm_encrypt(message, null, nonce, key);

        // Decrypt Data
        var plainText = sodium.crypto_aead_aes256gcm_decrypt(cipherText, null, nonce, key);

        // Test equality
        assert(sodium.compare(plainText, message)==0);
        done();
    });

    it("chacha20poly1305 should encrypt and decrypt to the same string", function (done) {
        var message = Buffer.from("This is a plain text message");
        var additionalData = Buffer.from("this is metadata");

        var nonce = Buffer.allocUnsafe(sodium.crypto_aead_chacha20poly1305_NPUBBYTES);
        sodium.randombytes_buf(nonce);

        var key = Buffer.allocUnsafe(sodium.crypto_aead_chacha20poly1305_KEYBYTES);
        sodium.randombytes_buf(key);

        // Encrypt data
        var cipherText = sodium.crypto_aead_chacha20poly1305_encrypt(message, additionalData, nonce, key);

        // Decrypt Data
        var plainText = sodium.crypto_aead_chacha20poly1305_decrypt(cipherText, additionalData, nonce, key);

        // Test equality
        assert(sodium.compare(plainText, message)==0);
        done();
    });

    it("chacha20poly1305 should encrypt and decrypt to the same string with null additional data", function (done) {
        var message = Buffer.from("This is a plain text message");

        var nonce = Buffer.allocUnsafe(sodium.crypto_aead_chacha20poly1305_NPUBBYTES);
        sodium.randombytes_buf(nonce);

        var key = Buffer.allocUnsafe(sodium.crypto_aead_chacha20poly1305_KEYBYTES);
        sodium.randombytes_buf(key);

        // Encrypt data
        var cipherText = sodium.crypto_aead_chacha20poly1305_encrypt(message, null, nonce, key);

        // Decrypt Data
        var plainText = sodium.crypto_aead_chacha20poly1305_decrypt(cipherText, null, nonce, key);

        // Test equality
        assert(sodium.compare(plainText, message)==0);
        done();
    });

    it("chacha20poly1305_ietf should encrypt and decrypt to the same string", function (done) {
        var message = Buffer.from("This is a plain text message");
        var additionalData = Buffer.from("this is metadata");

        var nonce = Buffer.allocUnsafe(sodium.crypto_aead_chacha20poly1305_ietf_NPUBBYTES);
        sodium.randombytes_buf(nonce);

        var key = Buffer.allocUnsafe(sodium.crypto_aead_chacha20poly1305_ietf_KEYBYTES);
        sodium.randombytes_buf(key);

        // Encrypt data
        var cipherText = sodium.crypto_aead_chacha20poly1305_ietf_encrypt(message, additionalData, nonce, key);

        // Decrypt Data
        var plainText = sodium.crypto_aead_chacha20poly1305_ietf_decrypt(cipherText, additionalData, nonce, key);

        // Test equality
        assert(sodium.compare(plainText, message)==0);
        done();
    });

    it("chacha20poly1305_ietf should encrypt and decrypt to the same string with null additional data", function (done) {
        var message = Buffer.from("This is a plain text message");

        var nonce = Buffer.allocUnsafe(sodium.crypto_aead_chacha20poly1305_ietf_NPUBBYTES);
        sodium.randombytes_buf(nonce);

        var key = Buffer.allocUnsafe(sodium.crypto_aead_chacha20poly1305_ietf_KEYBYTES);
        sodium.randombytes_buf(key);

        // Encrypt data
        var cipherText = sodium.crypto_aead_chacha20poly1305_ietf_encrypt(message, null, nonce, key);

        // Decrypt Data
        var plainText = sodium.crypto_aead_chacha20poly1305_ietf_decrypt(cipherText, null, nonce, key);

        // Test equality
        assert(sodium.compare(plainText, message)==0);
        done();
    });

    it("aes256gcm should encrypt and decrypt to the same string detached", function (done) {
        var message = Buffer.from("This is a plain text message");
        var additionalData = Buffer.from("this is metadata");

        var nonce = Buffer.allocUnsafe(sodium.crypto_aead_aes256gcm_NPUBBYTES);
        sodium.randombytes_buf(nonce);

        var key = Buffer.allocUnsafe(sodium.crypto_aead_aes256gcm_KEYBYTES);
        sodium.randombytes_buf(key);

        // If CPU does not support AES256gcm don't test
        if( !sodium.crypto_aead_aes256gcm_is_available() ) {
            console.log('AES 256 gcm not supported by CPU');
            done();
            return;
        }

        // Encrypt data
        var c = sodium.crypto_aead_aes256gcm_encrypt_detached(message, additionalData, nonce, key);

        // Decrypt Data
        var plainText = sodium.crypto_aead_aes256gcm_decrypt_detached(c.cipherText, c.mac, additionalData, nonce, key);

        // Test equality
        assert(sodium.compare(plainText, message)==0);
        done();
    });

    it("chacha20poly1305 should encrypt and decrypt to the same string detached", function (done) {
        var message = Buffer.from("This is a plain text message");
        var additionalData = Buffer.from("this is metadata");

        var nonce = Buffer.allocUnsafe(sodium.crypto_aead_chacha20poly1305_NPUBBYTES);
        sodium.randombytes_buf(nonce);

        var key = Buffer.allocUnsafe(sodium.crypto_aead_chacha20poly1305_KEYBYTES);
        sodium.randombytes_buf(key);

        // Encrypt data
        var c = sodium.crypto_aead_chacha20poly1305_encrypt_detached(message, additionalData, nonce, key);

        // Decrypt Data
        var plainText = sodium.crypto_aead_chacha20poly1305_decrypt_detached(c.cipherText, c.mac, additionalData, nonce, key);

        // Test equality
        assert(sodium.compare(plainText, message)==0);
        done();
    });

    it("chacha20poly1305_ietf should encrypt and decrypt to the same string detached", function (done) {
        var message = Buffer.from("This is a plain text message");
        var additionalData = Buffer.from("this is metadata");

        var nonce = Buffer.allocUnsafe(sodium.crypto_aead_chacha20poly1305_ietf_NPUBBYTES);
        sodium.randombytes_buf(nonce);

        var key = Buffer.allocUnsafe(sodium.crypto_aead_chacha20poly1305_ietf_KEYBYTES);
        sodium.randombytes_buf(key);

        // Encrypt data
        var c = sodium.crypto_aead_chacha20poly1305_ietf_encrypt_detached(message, additionalData, nonce, key);

        // Decrypt Data
        var plainText = sodium.crypto_aead_chacha20poly1305_ietf_decrypt_detached(c.cipherText, c.mac, additionalData, nonce, key);

        // Test equality
        assert(sodium.compare(plainText, message)==0);
        done();
    });
});

describe("AEAD Precompute Interface", function () {
    it("aes256gcm should encrypt and decrypt to the same string", function (done) {
        var message = Buffer.from("This is a plain text message");
        var additionalData = Buffer.from("this is metadata");

        var nonce = Buffer.allocUnsafe(sodium.crypto_aead_aes256gcm_NPUBBYTES);
        sodium.randombytes_buf(nonce);

        var key = Buffer.allocUnsafe(sodium.crypto_aead_aes256gcm_KEYBYTES);
        sodium.randombytes_buf(key);

        var ctx = sodium.crypto_aead_aes256gcm_beforenm(key);

        // If CPU does not support AES256gcm don't test
        if( !sodium.crypto_aead_aes256gcm_is_available() ) {
            console.log('AES 256 gcm not supported by CPU');
            done();
            return;
        }

        // Encrypt data
        var cipherText = sodium.crypto_aead_aes256gcm_encrypt_afternm(message, additionalData, nonce, ctx);

        // Decrypt Data
        var plainText = sodium.crypto_aead_aes256gcm_decrypt_afternm(cipherText, additionalData, nonce, ctx);

        // Test equality
        assert(sodium.compare(plainText, message)==0);
        done();
    });

    it("aes256gcm should encrypt and decrypt to the same string with null additional data", function (done) {
        var message = Buffer.from("This is a plain text message");
        var additionalData = Buffer.from("this is metadata");

        var nonce = Buffer.allocUnsafe(sodium.crypto_aead_aes256gcm_NPUBBYTES);
        sodium.randombytes_buf(nonce);

        var key = Buffer.allocUnsafe(sodium.crypto_aead_aes256gcm_KEYBYTES);
        sodium.randombytes_buf(key);

        var ctx = sodium.crypto_aead_aes256gcm_beforenm(key);

        // If CPU does not support AES256gcm don't test
        if( !sodium.crypto_aead_aes256gcm_is_available() ) {
            console.log('AES 256 gcm not supported by CPU');
            done();
            return;
        }

        // Encrypt data
        var cipherText = sodium.crypto_aead_aes256gcm_encrypt_afternm(message, null, nonce, ctx);

        // Decrypt Data
        var plainText = sodium.crypto_aead_aes256gcm_decrypt_afternm(cipherText, null, nonce, ctx);

        // Test equality
        assert(sodium.compare(plainText, message)==0);
        done();
    });

    it("aes256gcm should encrypt and decrypt to the same string detached", function (done) {
        var message = Buffer.from("This is a plain text message");
        var additionalData = Buffer.from("this is metadata");

        var nonce = Buffer.allocUnsafe(sodium.crypto_aead_aes256gcm_NPUBBYTES);
        sodium.randombytes_buf(nonce);

        var key = Buffer.allocUnsafe(sodium.crypto_aead_aes256gcm_KEYBYTES);
        sodium.randombytes_buf(key);

        var ctx = sodium.crypto_aead_aes256gcm_beforenm(key);

        // If CPU does not support AES256gcm don't test
        if( !sodium.crypto_aead_aes256gcm_is_available() ) {
            console.log('AES 256 gcm not supported by CPU');
            done();
            return;
        }

        // Encrypt data
        var c = sodium.crypto_aead_aes256gcm_encrypt_detached_afternm(message, additionalData, nonce, ctx);

        // Decrypt Data
        var plainText = sodium.crypto_aead_aes256gcm_decrypt_detached_afternm(c.cipherText, c.mac, additionalData, nonce, ctx);

        // Test equality
        assert(sodium.compare(plainText, message)==0);
        done();
    });


});
