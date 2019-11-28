/**
 * Node Native Module for Lib Sodium
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */
#include "node_sodium.h"
#include "crypto_core.h"

CRYPTO_CORE_DEF(hchacha20)
CRYPTO_CORE_DEF(hsalsa20)
CRYPTO_CORE_DEF(salsa20)
CRYPTO_CORE_DEF(salsa2012)
CRYPTO_CORE_DEF(salsa208)

/**
 * Register function calls in node binding
 */
void register_crypto_core(Handle<Object> target) {
    METHOD_AND_PROPS(hchacha20);
    METHOD_AND_PROPS(hsalsa20);
    METHOD_AND_PROPS(salsa20);
    METHOD_AND_PROPS(salsa2012);
    METHOD_AND_PROPS(salsa208);
}