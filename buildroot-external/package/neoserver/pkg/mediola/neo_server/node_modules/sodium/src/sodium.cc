/**
 * Node Native Module for Lib Sodium
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */
#include "node_sodium.h"
#include "node_sodium_register.h"

void RegisterModule(Handle<Object> target) {
    // init sodium library before we do anything
    if( sodium_init() == -1 ) {
        return Nan::ThrowError("libsodium cannot be initialized!");
    }

    randombytes_stir();

    register_helpers(target);
    register_runtime(target);
    register_randombytes(target);
    register_crypto_pwhash(target);
    register_crypto_hash(target);
    register_crypto_hash_sha256(target);
    register_crypto_hash_sha512(target);
    register_crypto_shorthash(target);
    register_crypto_shorthash_siphash24(target);
    register_crypto_generichash(target);
    register_crypto_generichash_blake2b(target);
    register_crypto_auth_algos(target);
    register_crypto_auth(target);
    register_crypto_onetimeauth(target);
    register_crypto_onetimeauth_poly1305(target);
    register_crypto_stream(target);
    register_crypto_streams(target);
    register_crypto_secretbox(target);
    register_crypto_secretbox_xsalsa20poly1305(target);
    register_crypto_sign(target);
    register_crypto_sign_ed25519(target);
    register_crypto_box(target);
    register_crypto_box_curve25519xsalsa20poly1305(target);
    register_crypto_scalarmult(target);
    register_crypto_scalarmult_curve25519(target);
    register_crypto_core(target);
    register_crypto_aead(target);
}

NODE_MODULE(sodium, RegisterModule);
