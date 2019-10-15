# General Use
The following objects are available in the `sodium` library

  * **api** - access to low level `libsodium` api
  * [**Utils**](./utilities_and_random_low_level_api.md#utilities) - utility functions
  * **Hash** - all hash functions
  * [**Random**](./utilities_and_random_low_level_api.md#random) - random number generator functions
  * [**Box**](box-low-level-api.md) - public key asymmetric crypto
  * [**SecretKey**](./secretbox-low-level-api.md) - symmetric key crypto
  * **Stream** - stream crypto
  * [**Sign**](sign-low-level-api.md) - signature generation and validation
  * **Auth** - authentication
  * **OneTimeAuth** - one time authentication
  * **Nonces** - nonce generation
  * **Key** - keys for all crypto functions


Lets generate a random number using by requiring the full `sodium` library

    var sodium = require('sodium');
    var n = sodium.api.randombytes_random();

Since we only need to call one method from the low level API we could require just the API functions like this:

    var lowLevelApi = require('sodium').api;
  	var n = lowlevelApi.randombytes_random();
  	
The same method can be applied to the other objects exposed through `sodium`.

The low level API gives you access to all ported `libsodium` functions directly. If you have experience using `libsodium` you can bypass the high-level APIs and use `libsodium` directly.

# Low Level API
`node-sodium` is a port of `libsodium` ([github repo](https://github.com/jedisct1/libsodium)), which it self is a port of the original [NaCl library](http://cr.yp.to/nacl) by Daniel Bernstein. The underlying library provides a C API that is exposed in `node-sodium` under the `.api` object. You can use the low level [documentation](./low-level-api.md) and examples to understand how to use it.

# High Level APIs
`node-soidum` defines a series of high level APIs that try to make it easier for the node developer to use. The high level APIs combine encryption, decryption functions, or sign and verify functions under the same class, while generating the appropriate keys, or nonces and taking care of message padding.

Due to the fact that NaCl defines a rich set of cryptographic functions, there are many different key types, key sizes, encryption primitives, and nonces that need to be generated and used appropriately. If mistakes are made your code won't work, or security will be compromised. The high level API thus provides a set of classes and methods that abstract these details from the developer in an attempt to avoid mistakes.

# Nonces

A nonce, or number used once, is an arbitrary number used only once in a cryptographic communication ([Wikipedia](http://en.wikipedia.org/wiki/Cryptographic_nonce)). As the name implies you should generate a new nonce for every message. By default, in `node-sodium`, nonces are random numbers of the appropriate size for the cryptographic algorithm being used. The size of each nonce is sufficient that the probability of collision, i.e. generating the same nonce twice, is very low. Therefore there is no need to keep a list of previously used nonces, which saves a lot of time and memory.

# Keys

Keys are fundamental to the security of any encryption method, and there are two basic types of keys used in `node-sodium`, secret keys, and public/secret key pairs. 

Secret keys, used by themselves or in a key pair, should always be kept a secret and should never be transmitted in the clear between sender and recipient of any message. There should always be a secure, often times offline, method so that sender and recipient can agree on a secret key.
Throughout `node-sodium` all secret keys use the `secretKey` or `sk` variable or parameter name. This allows consistent identification of all secret keys, and special care should be taken in their storage, management and use.
Public keys use the `publicKey` or `pk` identifier name, and can be shared, sent unencrypted, or stored without major concerns.
`node-sodium` does not provide a Public Key Infrastructure (PKI) with digital certificates by default, so you must consider man-in-the-middle attacks on public keys a possibility, and design your own key trust mechanisms.





