/**
 * Node Native Module for Lib Sodium
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */
#include "node_sodium.h"

/**
 * int crypto_scalarmult_curve25519_base(unsigned char *q, const unsigned char *n)
 */
NAN_METHOD(bind_crypto_scalarmult_curve25519_base) {
    Nan::EscapableHandleScope scope;

    ARGS(1,"argument must be a buffer");
    ARG_TO_UCHAR_BUFFER_LEN(n, crypto_scalarmult_curve25519_SCALARBYTES);
    
    NEW_BUFFER_AND_PTR(q, crypto_scalarmult_curve25519_BYTES);

    if (crypto_scalarmult_curve25519_base(q_ptr, n) == 0) {
        return info.GetReturnValue().Set(q);
    } else {
        return;
    }
}


/**
 * int crypto_scalarmult_curve25519(unsigned char *q, const unsigned char *n,
 *                  const unsigned char *p)
 */
NAN_METHOD(bind_crypto_scalarmult_curve25519) {
    Nan::EscapableHandleScope scope;

    ARGS(2,"arguments must be buffers");
    ARG_TO_UCHAR_BUFFER_LEN(n, crypto_scalarmult_curve25519_SCALARBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(p, crypto_scalarmult_curve25519_BYTES);

    NEW_BUFFER_AND_PTR(q, crypto_scalarmult_curve25519_BYTES);

    if (crypto_scalarmult_curve25519(q_ptr, n, p) == 0) {
        return info.GetReturnValue().Set(q);
    } else {
        return;
    }
}

/**
 * Register function calls in node binding
 */
void register_crypto_scalarmult_curve25519(Handle<Object> target) {
    // Scalar Mult
    NEW_METHOD(crypto_scalarmult_curve25519);
    NEW_METHOD(crypto_scalarmult_curve25519_base);
    NEW_INT_PROP(crypto_scalarmult_curve25519_SCALARBYTES);
    NEW_INT_PROP(crypto_scalarmult_curve25519_BYTES);
}