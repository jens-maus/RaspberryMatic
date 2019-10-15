var sodium = require('sodium').api;


// Generate keys
var sender = sodium.crypto_box_keypair();
var receiver = sodium.crypto_box_keypair();

// Generate random nonce
var nonce = Buffer.allocUnsafe(sodium.crypto_box_NONCEBYTES);
sodium.randombytes_buf(nonce);

// Encrypt
var plainText = Buffer.from('this is a message');
var cipherMsg = sodium.crypto_box(plainText, nonce, receiver.publicKey, sender.secretKey);

// Decrypt
var plainBuffer = sodium.crypto_box_open(cipherMsg, nonce, sender.publicKey,
	receiver.secretKey);

// We should get the same plainText!
if (plainBuffer.toString() == plainText) {
	console.log("Message decrypted correctly");
}
