/**
 * Node Native Module for Lib Sodium
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */
#include "node_sodium.h"
#include "crypto_onetimeauth_poly1305.h"

/**
 * Register function calls in node binding
 */
void register_crypto_onetimeauth(Handle<Object> target) {
    NEW_METHOD_ALIAS(crypto_onetimeauth, crypto_onetimeauth_poly1305);
    NEW_METHOD_ALIAS(crypto_onetimeauth_verify, crypto_onetimeauth_poly1305_verify);
    NEW_METHOD_ALIAS(crypto_onetimeauth_init, crypto_onetimeauth_poly1305_init);
    NEW_METHOD_ALIAS(crypto_onetimeauth_update, crypto_onetimeauth_poly1305_update);
    NEW_METHOD_ALIAS(crypto_onetimeauth_final, crypto_onetimeauth_poly1305_final);

    NEW_INT_PROP(crypto_onetimeauth_BYTES);
    NEW_INT_PROP(crypto_onetimeauth_KEYBYTES);
    NEW_STRING_PROP(crypto_onetimeauth_PRIMITIVE);
}