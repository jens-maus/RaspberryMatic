/**
 * Node Native Module for Lib Sodium
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */
#include "node_sodium.h"

/**
 * int crypto_onetimeauth_poly1305(
 *       unsigned char*  tok,
 *       const unsigned char * msg,
 *       unsigned long long mlen,
 *       const unsigned char * key)
 *
 * Parameters:
 *  [out] 	tok 	the generated authentication token.
 *  [in] 	msg 	the message to be authenticated.
 *  [in] 	mlen 	the length of msg.
 *  [in] 	key 	the key used to compute the token.
 */
NAN_METHOD(bind_crypto_onetimeauth_poly1305) {
    Nan::EscapableHandleScope scope;

    ARGS(2,"arguments message, and key must be buffers");
    ARG_TO_UCHAR_BUFFER(message);
    ARG_TO_UCHAR_BUFFER_LEN(key, crypto_onetimeauth_poly1305_KEYBYTES);

    NEW_BUFFER_AND_PTR(token, crypto_onetimeauth_poly1305_BYTES);

    if( crypto_onetimeauth_poly1305(token_ptr, message, message_size, key) == 0 ) {
        return info.GetReturnValue().Set(token);
    }

    return JS_NULL;
}

/**
 * int crypto_onetimeauth_poly1305_verify(
 *       unsigned char*  tok,
 *       const unsigned char * msg,
 *       unsigned long long mlen,
 *       const unsigned char * key)
 *
 * Parameters:
 *  [out] 	tok 	the generated authentication token.
 *  [in] 	msg 	the message to be authenticated.
 *  [in] 	mlen 	the length of msg.
 *  [in] 	key 	the key used to compute the token.
 */
NAN_METHOD(bind_crypto_onetimeauth_poly1305_verify) {
    Nan::EscapableHandleScope scope;

    ARGS(3,"arguments token, message, and key must be buffers");
    ARG_TO_UCHAR_BUFFER_LEN(token, crypto_onetimeauth_poly1305_BYTES);
    ARG_TO_UCHAR_BUFFER(message);
    ARG_TO_UCHAR_BUFFER_LEN(key, crypto_onetimeauth_poly1305_KEYBYTES);

    return info.GetReturnValue().Set(
        Nan::New<Integer>(crypto_onetimeauth_poly1305_verify(token, message, message_size, key))
    );
}

/*
int crypto_onetimeauth_poly1305_init(crypto_onetimeauth_poly1305_state *state,
                                     const unsigned char *key);

    buffer key
    return state
*/
NAN_METHOD(bind_crypto_onetimeauth_poly1305_init) {
    Nan::EscapableHandleScope scope;

    ARGS(1,"argument key must be a buffer");
    ARG_TO_UCHAR_BUFFER_LEN(key, crypto_onetimeauth_poly1305_KEYBYTES);

    NEW_BUFFER_AND_PTR(state, sizeof(crypto_onetimeauth_poly1305_state));

    if (crypto_onetimeauth_poly1305_init((crypto_onetimeauth_poly1305_state *)state_ptr, key) == 0) {
        return info.GetReturnValue().Set(state);
    }

    return JS_NULL;
}

/*
int crypto_onetimeauth_poly1305_update(crypto_onetimeauth_poly1305_state *state,
                                       const unsigned char *in,
                                       unsigned long long inlen);
*/
NAN_METHOD(bind_crypto_onetimeauth_poly1305_update) {
    Nan::EscapableHandleScope scope;

    ARGS(2,"arguments must be: state buffer, message buffer");

    ARG_TO_VOID_BUFFER(state);
    ARG_TO_UCHAR_BUFFER(message);

    NEW_BUFFER_AND_PTR(state2, sizeof(crypto_onetimeauth_poly1305_state));
    memcpy(state2_ptr, state, sizeof(crypto_onetimeauth_poly1305_state));

    crypto_onetimeauth_poly1305_update((crypto_onetimeauth_poly1305_state *)state2_ptr, message, message_size);
    return info.GetReturnValue().Set(state2);
}


/*
int crypto_onetimeauth_poly1305_final(crypto_onetimeauth_poly1305_state *state,
                                      unsigned char *out);
*/
NAN_METHOD(bind_crypto_onetimeauth_poly1305_final) {
    Nan::EscapableHandleScope scope;

    ARGS(1,"arguments must be: state buffer");
    ARG_TO_VOID_BUFFER(state);

    NEW_BUFFER_AND_PTR(out, crypto_onetimeauth_poly1305_BYTES);

    if (crypto_onetimeauth_poly1305_final((crypto_onetimeauth_poly1305_state *)state, out_ptr) == 0) {
        return info.GetReturnValue().Set(out);
    }

    return JS_NULL;
}

/**
 * Register function calls in node binding
 */
void register_crypto_onetimeauth_poly1305(Handle<Object> target) {
    // One Time Auth
    NEW_METHOD(crypto_onetimeauth_poly1305);
    NEW_METHOD(crypto_onetimeauth_poly1305_verify);
    NEW_METHOD(crypto_onetimeauth_poly1305_init);
    NEW_METHOD(crypto_onetimeauth_poly1305_update);
    NEW_METHOD(crypto_onetimeauth_poly1305_final);
    NEW_INT_PROP(crypto_onetimeauth_poly1305_BYTES);
    NEW_INT_PROP(crypto_onetimeauth_poly1305_KEYBYTES);
}