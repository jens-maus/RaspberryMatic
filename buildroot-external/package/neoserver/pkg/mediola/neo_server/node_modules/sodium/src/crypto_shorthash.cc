/**
 * Node Native Module for Lib Sodium
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */
#include "node_sodium.h"

/**
 * int crypto_shorthash(
 *    unsigned char *out,
 *    const unsigned char *in,
 *    unsigned long long inlen,
 *    const unsigned char *key)
 *
 * Parameters:
 *    [out] out    result of hash
 *    [in]  in     input buffer
 *    [in]  inlen  size of input buffer
 *    [in]  key    key buffer
 *
 * A lot of applications and programming language implementations have been
 * recently found to be vulnerable to denial-of-service attacks when a hash
 * function with weak security guarantees, like Murmurhash 3, was used to
 * construct a hash table.
 * In order to address this, Sodium provides the �shorthash� function,
 * currently implemented using SipHash-2-4. This very fast hash function
 * outputs short, but unpredictable (without knowing the secret key) values
 * suitable for picking a list in a hash table for a given key.
 */
NAN_METHOD(bind_crypto_shorthash) {
    Nan::EscapableHandleScope scope;

    NUMBER_OF_MANDATORY_ARGS(1,"argument message must be a buffer");

    GET_ARG_AS_UCHAR(0,message);
    GET_ARG_AS_UCHAR_LEN(1, key, crypto_shorthash_KEYBYTES);

    NEW_BUFFER_AND_PTR(hash, crypto_shorthash_BYTES);

    if( crypto_shorthash(hash_ptr, message, message_size, key) == 0 ) {
        return info.GetReturnValue().Set(hash);
    } else {
        return JS_NULL;
    }
}

/**
 * Register function calls in node binding
 */
void register_crypto_shorthash(Handle<Object> target) {
    // Short Hash
    NEW_METHOD(crypto_shorthash);
    NEW_INT_PROP(crypto_shorthash_BYTES);
    NEW_INT_PROP(crypto_shorthash_KEYBYTES);
    NEW_STRING_PROP(crypto_shorthash_PRIMITIVE);
}