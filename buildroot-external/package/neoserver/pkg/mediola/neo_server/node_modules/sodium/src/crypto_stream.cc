/**
 * Node Native Module for Lib Sodium
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */
#include "node_sodium.h"

#include "crypto_streams.h"

/**
 * Register function calls in node binding
 */
void register_crypto_stream(Handle<Object> target) {
    // Stream
    NEW_METHOD_ALIAS(crypto_stream, crypto_stream_xsalsa20);
    NEW_METHOD_ALIAS(crypto_stream_xor, crypto_stream_xsalsa20_xor);
    
    NEW_INT_PROP(crypto_stream_KEYBYTES);
    NEW_INT_PROP(crypto_stream_NONCEBYTES);
    NEW_STRING_PROP(crypto_stream_PRIMITIVE);
}