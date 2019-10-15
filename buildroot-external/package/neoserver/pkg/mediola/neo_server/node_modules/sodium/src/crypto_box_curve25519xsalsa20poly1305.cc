/**
 * Node Native Module for Lib Sodium
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */
#include "node_sodium.h"

NAN_METHOD(bind_crypto_box_curve25519xsalsa20poly1305) {
    Nan::EscapableHandleScope scope;

    ARGS(4,"arguments message, nonce, publicKey and secretKey must be buffers");
    ARG_TO_UCHAR_BUFFER(message);
    ARG_TO_UCHAR_BUFFER_LEN(nonce, crypto_box_curve25519xsalsa20poly1305_NONCEBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(publicKey, crypto_box_curve25519xsalsa20poly1305_PUBLICKEYBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(secretKey, crypto_box_curve25519xsalsa20poly1305_SECRETKEYBYTES);

    NEW_BUFFER_AND_PTR(msg, message_size + crypto_box_curve25519xsalsa20poly1305_ZEROBYTES);

    // Fill the first crypto_box_curve25519xsalsa20poly1305_ZEROBYTES with 0
    unsigned int i;
    for(i = 0; i < crypto_box_curve25519xsalsa20poly1305_ZEROBYTES; i++) {
       msg_ptr[i] = 0U;
    }

    //Copy the message to the new buffer
    memcpy((void*) (msg_ptr + crypto_box_curve25519xsalsa20poly1305_ZEROBYTES), (void *) message, message_size);
    message_size += crypto_box_curve25519xsalsa20poly1305_ZEROBYTES;

    NEW_BUFFER_AND_PTR(ctxt, message_size);

    if (crypto_box_curve25519xsalsa20poly1305(ctxt_ptr, msg_ptr, message_size, nonce, publicKey, secretKey) == 0) {
        return info.GetReturnValue().Set(ctxt);
    } else {
        return;
    }
}

NAN_METHOD(bind_crypto_box_curve25519xsalsa20poly1305_keypair) {
    Nan::EscapableHandleScope scope;

    NEW_BUFFER_AND_PTR(pk, crypto_box_curve25519xsalsa20poly1305_PUBLICKEYBYTES);
    NEW_BUFFER_AND_PTR(sk, crypto_box_curve25519xsalsa20poly1305_SECRETKEYBYTES);

    if (crypto_box_curve25519xsalsa20poly1305_keypair(pk_ptr, sk_ptr) == 0) {
        Local<Object> result = Nan::New<Object>();

        JS_OBJECT_SET_PROPERTY(result, "publicKey", pk);
        JS_OBJECT_SET_PROPERTY(result, "secretKey", sk);

        return JS_OBJECT(result);
    } else {
        return;
    }
}

NAN_METHOD(bind_crypto_box_curve25519xsalsa20poly1305_open) {
    Nan::EscapableHandleScope scope;

    ARGS(4,"arguments cipherText, nonce, publicKey and secretKey must be buffers");
    ARG_TO_UCHAR_BUFFER(cipherText);
    ARG_TO_UCHAR_BUFFER_LEN(nonce, crypto_box_curve25519xsalsa20poly1305_NONCEBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(publicKey, crypto_box_curve25519xsalsa20poly1305_PUBLICKEYBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(secretKey, crypto_box_curve25519xsalsa20poly1305_SECRETKEYBYTES);

    // API requires that the first crypto_box_curve25519xsalsa20poly1305_BOXZEROBYTES of msg be 0 so lets check
    if (cipherText_size < crypto_box_curve25519xsalsa20poly1305_BOXZEROBYTES) {
        std::ostringstream oss;
        oss << "argument cipherText must have a length of at least " << crypto_box_curve25519xsalsa20poly1305_BOXZEROBYTES << " bytes";
        return Nan::ThrowError(oss.str().c_str());
    }

    unsigned int i;

    for (i = 0; i < crypto_box_curve25519xsalsa20poly1305_BOXZEROBYTES; i++) {
        if( cipherText[i] ) break;
    }

    if (i < crypto_box_curve25519xsalsa20poly1305_BOXZEROBYTES) {
        std::ostringstream oss;
        oss << "the first " << crypto_box_curve25519xsalsa20poly1305_BOXZEROBYTES << " bytes of argument cipherText must be 0";
        return Nan::ThrowError(oss.str().c_str());
    }

    NEW_BUFFER_AND_PTR(msg, cipherText_size);

    if (crypto_box_curve25519xsalsa20poly1305_open(msg_ptr, cipherText, cipherText_size, nonce, publicKey, secretKey) == 0) {

        // Remove the padding at the beginning of the message
        NEW_BUFFER_AND_PTR(plain_text, cipherText_size - crypto_box_curve25519xsalsa20poly1305_ZEROBYTES);
        memcpy(plain_text_ptr,(void*) (msg_ptr + crypto_box_curve25519xsalsa20poly1305_ZEROBYTES), cipherText_size - crypto_box_curve25519xsalsa20poly1305_ZEROBYTES);

        return info.GetReturnValue().Set(plain_text);
    } else {
        return;
    }
}

NAN_METHOD(bind_crypto_box_curve25519xsalsa20poly1305_beforenm) {
    Nan::EscapableHandleScope scope;

    ARGS(2,"arguments publicKey, and secretKey must be buffers");
    ARG_TO_UCHAR_BUFFER_LEN(publicKey, crypto_box_curve25519xsalsa20poly1305_PUBLICKEYBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(secretKey, crypto_box_curve25519xsalsa20poly1305_SECRETKEYBYTES);

    NEW_BUFFER_AND_PTR(k, crypto_box_curve25519xsalsa20poly1305_BEFORENMBYTES);

    if( crypto_box_curve25519xsalsa20poly1305_beforenm(k_ptr, publicKey, secretKey) != 0) {
      return Nan::ThrowError("crypto_box_curve25519xsalsa20poly1305_beforenm failed");
    }

    return info.GetReturnValue().Set(k);
}

NAN_METHOD(bind_crypto_box_curve25519xsalsa20poly1305_afternm) {
    Nan::EscapableHandleScope scope;

    ARGS(3,"arguments message, nonce and k must be buffers");
    ARG_TO_UCHAR_BUFFER(message);
    ARG_TO_UCHAR_BUFFER_LEN(nonce, crypto_box_curve25519xsalsa20poly1305_NONCEBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(k, crypto_box_curve25519xsalsa20poly1305_BEFORENMBYTES);

    // Pad the message with crypto_box_curve25519xsalsa20poly1305_ZEROBYTES zeros
    NEW_BUFFER_AND_PTR(msg, message_size + crypto_box_curve25519xsalsa20poly1305_ZEROBYTES);

    unsigned int i;
    for(i = 0; i < crypto_box_curve25519xsalsa20poly1305_ZEROBYTES; i++) {
       msg_ptr[i] = 0U;
    }

    //Copy the message to the new buffer
    memcpy((void*) (msg_ptr + crypto_box_curve25519xsalsa20poly1305_ZEROBYTES), (void *) message, message_size);
    message_size += crypto_box_curve25519xsalsa20poly1305_ZEROBYTES;

    NEW_BUFFER_AND_PTR(ctxt, message_size);

    if (crypto_box_curve25519xsalsa20poly1305_afternm(ctxt_ptr, msg_ptr, message_size, nonce, k) == 0) {
        return info.GetReturnValue().Set(ctxt);
    } else {
        return;
    }
}

NAN_METHOD(bind_crypto_box_curve25519xsalsa20poly1305_open_afternm) {
    Nan::EscapableHandleScope scope;

    ARGS(3,"arguments cipherText, nonce, k");
    ARG_TO_UCHAR_BUFFER(cipherText);
    ARG_TO_UCHAR_BUFFER_LEN(nonce, crypto_box_curve25519xsalsa20poly1305_NONCEBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(k, crypto_box_curve25519xsalsa20poly1305_BEFORENMBYTES);

    // API requires that the first crypto_box_curve25519xsalsa20poly1305_BOXZEROBYTES of msg be 0 so lets check
    if (cipherText_size < crypto_box_curve25519xsalsa20poly1305_BOXZEROBYTES) {
        std::ostringstream oss;
        oss << "argument cipherText must have a length of at least " << crypto_box_curve25519xsalsa20poly1305_BOXZEROBYTES << " bytes";
        return Nan::ThrowError(oss.str().c_str());
    }

    unsigned int i;
    for(i = 0; i < crypto_box_curve25519xsalsa20poly1305_BOXZEROBYTES; i++) {
        if( cipherText[i] ) break;
    }

    if (i < crypto_box_curve25519xsalsa20poly1305_BOXZEROBYTES) {
        std::ostringstream oss;
        oss << "the first " << crypto_box_curve25519xsalsa20poly1305_BOXZEROBYTES << " bytes of argument cipherText must be 0";
        return Nan::ThrowError(oss.str().c_str());
    }

    NEW_BUFFER_AND_PTR(msg, cipherText_size);

    if (crypto_box_curve25519xsalsa20poly1305_open_afternm(msg_ptr, cipherText, cipherText_size, nonce, k) == 0) {

        // Remove the padding at the beginning of the message
        NEW_BUFFER_AND_PTR(plain_text,cipherText_size - crypto_box_curve25519xsalsa20poly1305_ZEROBYTES);
        memcpy(plain_text_ptr,(void*) (msg_ptr + crypto_box_curve25519xsalsa20poly1305_ZEROBYTES), cipherText_size - crypto_box_curve25519xsalsa20poly1305_ZEROBYTES);

        return info.GetReturnValue().Set(plain_text);
    } else {
        return;
    }
}

/**
 * Register function calls in node binding
 */
void register_crypto_box_curve25519xsalsa20poly1305(Handle<Object> target) {
     // Box
    NEW_METHOD(crypto_box_curve25519xsalsa20poly1305);
    NEW_METHOD(crypto_box_curve25519xsalsa20poly1305_keypair);
    NEW_METHOD(crypto_box_curve25519xsalsa20poly1305_open);
    NEW_METHOD(crypto_box_curve25519xsalsa20poly1305_beforenm);
    NEW_METHOD(crypto_box_curve25519xsalsa20poly1305_afternm);
    NEW_METHOD(crypto_box_curve25519xsalsa20poly1305_open_afternm);
    
    NEW_INT_PROP(crypto_box_curve25519xsalsa20poly1305_NONCEBYTES);
    NEW_INT_PROP(crypto_box_curve25519xsalsa20poly1305_MACBYTES);
    NEW_INT_PROP(crypto_box_curve25519xsalsa20poly1305_BEFORENMBYTES);
    NEW_INT_PROP(crypto_box_curve25519xsalsa20poly1305_BOXZEROBYTES);
    NEW_INT_PROP(crypto_box_curve25519xsalsa20poly1305_PUBLICKEYBYTES);
    NEW_INT_PROP(crypto_box_curve25519xsalsa20poly1305_SECRETKEYBYTES);
    NEW_INT_PROP(crypto_box_curve25519xsalsa20poly1305_ZEROBYTES);
    NEW_INT_PROP(crypto_box_curve25519xsalsa20poly1305_SEEDBYTES);
}