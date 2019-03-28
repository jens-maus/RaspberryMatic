/**
 * Node Native Module for Lib Sodium
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */
#include "node_sodium.h"

/**
 * int crypto_generichash(unsigned char *out,
 *                        size_t outlen,
 *                        const unsigned char *in,
 *                        unsigned long long inlen,
 *                        const unsigned char *key,
 *                        size_t keylen);
 *  buffer out,
 *  number out_size,
 *  buffer in,
 *  buffer key
 */
NAN_METHOD(bind_crypto_generichash) {
    Nan::EscapableHandleScope scope;

    ARGS(3,"arguments must be: hash size, message, key");
    ARG_TO_NUMBER(out_size);
    ARG_TO_UCHAR_BUFFER(in);
    ARG_TO_UCHAR_BUFFER_OR_NULL(key);

    if (key != NULL) {
        CHECK_SIZE(key_size, crypto_generichash_KEYBYTES_MIN, crypto_generichash_KEYBYTES_MAX);
    }
    CHECK_SIZE(out_size, crypto_generichash_BYTES_MIN, crypto_generichash_BYTES_MAX);

    NEW_BUFFER_AND_PTR(hash, out_size);
    sodium_memzero(hash_ptr, out_size);

    if (crypto_generichash(hash_ptr, out_size, in, in_size, key, key_size) == 0) {
        return info.GetReturnValue().Set(hash);
    }

    return JS_NULL;
}

/*
int crypto_generichash_init(crypto_generichash_state *state,
                            const unsigned char *key,
                            const size_t keylen, const size_t outlen);
  Buffer state
  Buffer key
  Number out_size
  state = sodium_malloc((crypto_generichash_statebytes() + (size_t) 63U)
 *                       & ~(size_t) 63U);
*/
NAN_METHOD(bind_crypto_generichash_init) {
    Nan::EscapableHandleScope scope;

    ARGS(2,"arguments must be: key buffer, output size");
    ARG_TO_UCHAR_BUFFER(key);
    ARG_TO_NUMBER(out_size);

    CHECK_SIZE(key_size, crypto_generichash_KEYBYTES_MIN, crypto_generichash_KEYBYTES_MAX);
    CHECK_SIZE(out_size, crypto_generichash_BYTES_MIN, crypto_generichash_BYTES_MAX);

    NEW_BUFFER_AND_PTR(state, (crypto_generichash_statebytes() + (size_t) 63U) & ~(size_t) 63U);

    if (crypto_generichash_init((crypto_generichash_state *)state_ptr, key, key_size, out_size) == 0) {
        return info.GetReturnValue().Set(state);
    }

    return JS_NULL;
}


/*
int crypto_generichash_update(crypto_generichash_state *state,
                              const unsigned char *in,
                              unsigned long long inlen);

    buffer state
    buffer message
*/
NAN_METHOD(bind_crypto_generichash_update) {
    Nan::EscapableHandleScope scope;

    ARGS(2,"arguments must be: state buffer, message buffer");

    ARG_TO_VOID_BUFFER(state);
    ARG_TO_UCHAR_BUFFER(message);

    NEW_BUFFER_AND_PTR(state2, (crypto_generichash_statebytes() + (size_t) 63U) & ~(size_t) 63U);
    memcpy(state2_ptr, state, (crypto_generichash_statebytes() + (size_t) 63U) & ~(size_t) 63U);

    crypto_generichash_update((crypto_generichash_state *)state2_ptr, message, message_size);
    return info.GetReturnValue().Set(state2);
}

/*
int crypto_generichash_final(crypto_generichash_state *state,
                             unsigned char *out, const size_t outlen);
*/
NAN_METHOD(bind_crypto_generichash_final) {
    Nan::EscapableHandleScope scope;

    ARGS(2,"arguments must be: state buffer, output size");
    ARG_TO_VOID_BUFFER(state);
    ARG_TO_NUMBER(out_size);

    CHECK_SIZE(out_size, crypto_generichash_BYTES_MIN, crypto_generichash_BYTES_MAX);
    NEW_BUFFER_AND_PTR(hash, out_size);

    if (crypto_generichash_final((crypto_generichash_state *)state, hash_ptr, out_size) == 0) {
        return info.GetReturnValue().Set(hash);
    }

    return JS_NULL;
}

/**
 * Register function calls in node binding
 */
void register_crypto_generichash(Handle<Object> target) {
     // Generic Hash
    NEW_METHOD(crypto_generichash);
    NEW_METHOD(crypto_generichash_init);
    NEW_METHOD(crypto_generichash_update);
    NEW_METHOD(crypto_generichash_final);
    NEW_STRING_PROP(crypto_generichash_PRIMITIVE);
    NEW_INT_PROP(crypto_generichash_BYTES);
    NEW_INT_PROP(crypto_generichash_BYTES_MIN);
    NEW_INT_PROP(crypto_generichash_BYTES_MAX);
    NEW_INT_PROP(crypto_generichash_KEYBYTES);
    NEW_INT_PROP(crypto_generichash_KEYBYTES_MIN);
    NEW_INT_PROP(crypto_generichash_KEYBYTES_MAX);
}