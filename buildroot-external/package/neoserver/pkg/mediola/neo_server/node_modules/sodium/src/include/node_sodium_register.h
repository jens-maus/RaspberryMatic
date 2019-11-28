#ifndef __NODE_SODIUM_REGISTER_H__
#define __NODE_SODIUM_REGISTER_H__

#include <node.h>

void register_helpers(Handle<Object> target);
void register_randombytes(Handle<Object> target);
void register_crypto_pwhash(Handle<Object> target);
void register_crypto_hash(Handle<Object> target);
void register_crypto_hash_sha256(Handle<Object> target);
void register_crypto_hash_sha512(Handle<Object> target);
void register_crypto_shorthash(Handle<Object> target);
void register_crypto_shorthash_siphash24(Handle<Object> target);
void register_crypto_generichash(Handle<Object> target);
void register_crypto_generichash_blake2b(Handle<Object> target);
void register_crypto_auth(Handle<Object> target);
void register_crypto_onetimeauth(Handle<Object> target);
void register_crypto_onetimeauth_poly1305(Handle<Object> target);
void register_crypto_stream(Handle<Object> target);
void register_crypto_streams(Handle<Object> target);
void register_crypto_secretbox(Handle<Object> target);
void register_crypto_secretbox_xsalsa20poly1305(Handle<Object> target);
void register_crypto_sign(Handle<Object> target);
void register_crypto_sign_ed25519(Handle<Object> target);
void register_crypto_box(Handle<Object> target);
void register_crypto_scalarmult(Handle<Object> target);
void register_crypto_scalarmult_curve25519(Handle<Object> target);
void register_crypto_core(Handle<Object> target);
void register_crypto_auth_algos(Handle<Object> target);
void register_crypto_aead(Handle<Object> target);
void register_runtime(Handle<Object> target);
void register_crypto_box_curve25519xsalsa20poly1305(Handle<Object> target);

#endif
