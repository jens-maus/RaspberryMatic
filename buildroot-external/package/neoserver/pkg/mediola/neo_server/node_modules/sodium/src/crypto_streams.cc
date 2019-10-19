/**
 * Node Native Module for Lib Sodium
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */
#include "node_sodium.h"
#include "crypto_streams.h"

// Generate the binding methods for each algorithm
CRYPTO_STREAM_DEF(salsa20)
CRYPTO_STREAM_DEF_IC(salsa20)
CRYPTO_STREAM_DEF(xsalsa20)
CRYPTO_STREAM_DEF_IC(xsalsa20)
CRYPTO_STREAM_DEF(salsa208)
CRYPTO_STREAM_DEF(salsa2012)
CRYPTO_STREAM_DEF(chacha20)
CRYPTO_STREAM_DEF_IC(chacha20)

// chacha_ietf uses the same key length as crypto_stream_chacha20_KEYBYTES
// Libsodium does not define it, lets define it here so we don't get compilation errors
// when expanding the macros
// #define crypto_stream_chacha20_ietf_KEYBYTES   crypto_stream_chacha20_KEYBYTES
//#define crypto_stream_chacha20_ietf_NONCEBYTES crypto_stream_chacha20_IETF_NONCEBYTES
CRYPTO_STREAM_DEF(chacha20_ietf)
CRYPTO_STREAM_DEF_IC(chacha20_ietf)


/**
 * Register function calls in node binding
 */
void register_crypto_streams(Handle<Object> target) {
    
    METHODS(xsalsa20);
    NEW_METHOD(crypto_stream_xsalsa20_xor_ic);
    PROPS(xsalsa20);
    
    METHODS(salsa20);
    NEW_METHOD(crypto_stream_salsa20_xor_ic);
    PROPS(salsa20);
    
    METHODS(salsa208);
    PROPS(salsa208);
    
    METHODS(salsa2012);
    PROPS(salsa2012);
    
    METHODS(chacha20);
    NEW_METHOD(crypto_stream_chacha20_xor_ic);
    PROPS(chacha20);
    
    METHODS(chacha20_ietf);
    NEW_METHOD(crypto_stream_chacha20_ietf_xor_ic);
    PROPS(chacha20_ietf);
}