/**
 * Node Native Module for Lib Sodium
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */
#include "node_sodium.h"
#include "crypto_auth_algos.h"


/**
 * Register function calls in node binding
 */
void register_crypto_auth(Handle<Object> target) {
    // Auth
    NEW_METHOD_ALIAS(crypto_auth, crypto_auth_hmacsha512256);
    NEW_METHOD_ALIAS(crypto_auth_verify, crypto_auth_hmacsha512256_verify);

    NEW_INT_PROP(crypto_auth_BYTES);
    NEW_INT_PROP(crypto_auth_KEYBYTES);
    NEW_STRING_PROP(crypto_auth_PRIMITIVE);
}