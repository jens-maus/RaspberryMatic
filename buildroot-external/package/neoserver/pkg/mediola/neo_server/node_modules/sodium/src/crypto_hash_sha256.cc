/**
 * Node Native Module for Lib Sodium
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */
#include "node_sodium.h"

/**
 * int crypto_hash_sha256(
 *    unsigned char * hbuf,
 *    const unsigned char * msg,
 *    unsigned long long mlen)
 */
NAN_METHOD(bind_crypto_hash_sha256) {
    Nan::EscapableHandleScope scope;

    ARGS(1,"argument message must be a buffer");
    ARG_TO_UCHAR_BUFFER(msg);

    NEW_BUFFER_AND_PTR(hash, crypto_hash_sha256_BYTES);

    if( crypto_hash_sha256(hash_ptr, msg, msg_size) == 0 ) {
        return info.GetReturnValue().Set(hash);
    }

    return JS_NULL;
}

/*
 * int crypto_hash_sha256_init(crypto_hash_sha256_state *state);
 */
NAN_METHOD(bind_crypto_hash_sha256_init) {
    Nan::EscapableHandleScope scope;

    NEW_BUFFER_AND_PTR(state, crypto_hash_sha256_statebytes());

    if( crypto_hash_sha256_init((crypto_hash_sha256_state*) state_ptr) == 0 ) {
        return info.GetReturnValue().Set(state);
    }

    return JS_NULL;
}

/* int crypto_hash_sha256_update(crypto_hash_sha256_state *state,
                              const unsigned char *in,
                              unsigned long long inlen);

    Buffer state
    Buffer inStr
 */
NAN_METHOD(bind_crypto_hash_sha256_update) {
    Nan::EscapableHandleScope scope;

    ARGS(2,"arguments must be two buffers: hash state, message part");
    ARG_TO_VOID_BUFFER(state);
    ARG_TO_UCHAR_BUFFER(msg);

    NEW_BUFFER_AND_PTR(state2, crypto_hash_sha256_statebytes());
    memcpy(state2_ptr, state, crypto_hash_sha256_statebytes());

    if( crypto_hash_sha256_update((crypto_hash_sha256_state*)state2_ptr, msg, msg_size) == 0 ) {
        return info.GetReturnValue().Set(state2);
    }

    return JS_NULL;
}

/* int crypto_hash_sha256_final(crypto_hash_sha256_state *state,
                             unsigned char *out);

 */
NAN_METHOD(bind_crypto_hash_sha256_final) {
    Nan::EscapableHandleScope scope;

    ARGS(1,"arguments must be a hash state buffer");
    ARG_TO_VOID_BUFFER(state);
    NEW_BUFFER_AND_PTR(hash, crypto_hash_sha256_BYTES);

    if( crypto_hash_sha256_final((crypto_hash_sha256_state*)state, hash_ptr) == 0 ) {
        return info.GetReturnValue().Set(hash);
    }

    return JS_FALSE;
}

/**
 * Register function calls in node binding
 */
void register_crypto_hash_sha256(Handle<Object> target) {

    // Hash
    NEW_METHOD(crypto_hash_sha256);
    NEW_METHOD(crypto_hash_sha256_init);
    NEW_METHOD(crypto_hash_sha256_update);
    NEW_METHOD(crypto_hash_sha256_final);
    NEW_INT_PROP(crypto_hash_sha256_BYTES);
}