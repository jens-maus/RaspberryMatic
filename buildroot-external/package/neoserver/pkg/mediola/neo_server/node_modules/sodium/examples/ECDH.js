var sodium = require('../lib/sodium');
var should = require('should');

// Generate Alice's and Bob's key pairs
var bob = new sodium.Key.ECDH();
var alice = new sodium.Key.ECDH();

// Now alice and bob exchange public keys
// To keep this example simple the network, and public key exchanges are
// simulated by using the variables alicePublicKey, and bobPublicKey
alicePublicKey = alice.pk().get();
bobPublicKey = bob.pk().get();

// Once Alice gets Bob's public key she can initialize the
// Eliptic Curve Diffie-Helman object with her secret key
// and Bob's public key
var aliceDH = new sodium.ECDH(bobPublicKey, alice.sk().get());

// Alice calculates the Diffie-Helman secret
var aliceSecret = aliceDH.secret();

// Bob uses Alice's public key to initialize the
// Eliptic Curve Diffie-Helman object with his secret key
// and Alice's public key
var bobDH = new sodium.ECDH(alicePublicKey, bob.sk().get());

// Bob calculates the Diffie-Helman secret
var bobSecret = bobDH.secret();

// Alice and Bob should now have the same secret and the key exchange
// is complete
bobSecret.should.eql(aliceSecret);
console.log('DH Secrets Match!');

// The Diffie-Helman secret should not be used directly as an encryption key
// You can take the secret and hash it using your "favorite" hash function or
// you can use ECDG.sessionKey to get a valid session Key
var bobSessionKey = bobDH.sessionKey();
var aliceSessionKey = aliceDH.sessionKey();

aliceSessionKey.should.eql(bobSessionKey);
console.log('Sessions Keys Match!');
