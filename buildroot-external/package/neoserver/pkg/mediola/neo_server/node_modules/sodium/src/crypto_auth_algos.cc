/**
 * Node Native Module for Lib Sodium
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */
#include "node_sodium.h"
#include "crypto_auth_algos.h"

CRYPTO_AUTH_DEF(hmacsha256)
CRYPTO_AUTH_DEF(hmacsha512)
CRYPTO_AUTH_DEF(hmacsha512256)

/**
 * Register function calls in node binding
 */
void register_crypto_auth_algos(Handle<Object> target) {
    METHOD_AND_PROPS(hmacsha256)
    METHOD_AND_PROPS(hmacsha512)
    METHOD_AND_PROPS(hmacsha512256)
}