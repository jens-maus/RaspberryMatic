/**
 * Node Native Module for Lib Sodium
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */
#ifndef __CRYPTO_SIGN_ED25519_H__
#define __CRYPTO_SIGN_ED25519_H__

NAN_METHOD(bind_crypto_sign_ed25519);
NAN_METHOD(bind_crypto_sign_ed25519_open);
NAN_METHOD(bind_crypto_sign_ed25519_detached);
NAN_METHOD(bind_crypto_sign_ed25519_verify_detached);
NAN_METHOD(bind_crypto_sign_ed25519_keypair);
NAN_METHOD(bind_crypto_sign_ed25519_seed_keypair);
NAN_METHOD(bind_crypto_sign_ed25519_pk_to_curve25519);
NAN_METHOD(bind_crypto_sign_ed25519_sk_to_curve25519);
NAN_METHOD(bind_crypto_sign_ed25519_sk_to_seed);
NAN_METHOD(bind_crypto_sign_ed25519_sk_to_pk);
    
#endif