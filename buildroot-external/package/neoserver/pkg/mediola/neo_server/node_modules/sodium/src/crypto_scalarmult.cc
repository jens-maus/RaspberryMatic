/**
 * Node Native Module for Lib Sodium
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */
#include "node_sodium.h"
#include "crypto_scalarmult_curve25519.h"

/**
 * Register function calls in node binding
 */
void register_crypto_scalarmult(Handle<Object> target) {
    // Scalar Mult
    NEW_METHOD_ALIAS(crypto_scalarmult, crypto_scalarmult_curve25519);
    NEW_METHOD_ALIAS(crypto_scalarmult_base, crypto_scalarmult_curve25519_base);
    
    NEW_INT_PROP(crypto_scalarmult_SCALARBYTES);
    NEW_INT_PROP(crypto_scalarmult_BYTES);
    NEW_STRING_PROP(crypto_scalarmult_PRIMITIVE);
}