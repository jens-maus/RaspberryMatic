var sodium = require('sodium').api;

function generateKey (len) {
  var key = Buffer.allocUnsafe(len);
  sodium.randombytes_buf(key, len);
  return key
}

var message = Buffer.from('Time flies like an arrow; fruit flies like a banana.')
var key1 = generateKey(sodium.crypto_generichash_KEYBYTES);
var hash1 = sodium.crypto_generichash(sodium.crypto_generichash_BYTES, message, key1);
console.log('       crypto_generichash:', hash1.toString('base64'));

// Streaming API for larger files or data streams
var chunk1 = Buffer.from('One must acknowledge with cryptography ');
var chunk2 = Buffer.from('no amount of violence will ever solve a math problem.');
var key2 = generateKey(sodium.crypto_generichash_KEYBYTES);

var state = sodium.crypto_generichash_init(key2, sodium.crypto_generichash_BYTES);
state = sodium.crypto_generichash_update(state, chunk1);
state = sodium.crypto_generichash_update(state, chunk2);
var hash2 = sodium.crypto_generichash_final(state, sodium.crypto_generichash_BYTES);
console.log('Generichash streaming API:', hash2.toString('base64'));

