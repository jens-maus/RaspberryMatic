/**
 * Node Native Module for Lib Sodium
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */
#include "node_sodium.h"

/**
 * Encrypts a message given the senders secret key, and receivers public key.
 * int crypto_box	(
 *    unsigned char * ctxt,
 *    const unsigned char * msg,
 *    unsigned long long mlen,
 *    const unsigned char * nonce,
 *    const unsigned char * pk,
 *    const unsigned char * sk)
 *
 * Parameters:
 *    [out] ctxt    the buffer for the cipher-text.
 *    [in] 	msg     the message to be encrypted.
 *    [in] 	mlen    the length of msg.
 *    [in] 	nonce   a randomly generated nonce.
 *    [in] 	pk 	    the receivers public key, used for encryption.
 *    [in] 	sk 	    the senders private key, used for signing.
 *
 * Returns:
 *    0 if operation is successful.
 *
 * Precondition:
 *    first crypto_box_ZEROBYTES of msg be all 0.
 *    the nonce must have size crypto_box_NONCEBYTES.
 *
 * Postcondition:
 *    first crypto_box_BOXZEROBYTES of ctxt be all 0.
 *    first mlen bytes of ctxt will contain the ciphertext.
 */
NAN_METHOD(bind_crypto_box) {
    Nan::EscapableHandleScope scope;

    ARGS(4,"arguments message, nonce, publicKey and secretKey must be buffers");
    ARG_TO_UCHAR_BUFFER(message);
    ARG_TO_UCHAR_BUFFER_LEN(nonce, crypto_box_NONCEBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(publicKey, crypto_box_PUBLICKEYBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(secretKey, crypto_box_SECRETKEYBYTES);

    NEW_BUFFER_AND_PTR(msg, message_size + crypto_box_ZEROBYTES);

    // Fill the first crypto_box_ZEROBYTES with 0
    unsigned int i;
    for(i = 0; i < crypto_box_ZEROBYTES; i++) {
       msg_ptr[i] = 0U;
    }

    //Copy the message to the new buffer
    memcpy((void*) (msg_ptr + crypto_box_ZEROBYTES), (void *) message, message_size);
    message_size += crypto_box_ZEROBYTES;

    NEW_BUFFER_AND_PTR(ctxt, message_size);

    if (crypto_box(ctxt_ptr, msg_ptr, message_size, nonce, publicKey, secretKey) == 0) {
        return info.GetReturnValue().Set(ctxt);
    } else {
        return;
    }
}

/**
 * Encrypts a message given the senders secret key, and receivers public key.
 * int crypto_box_easy   (
 *    unsigned char * ctxt,
 *    const unsigned char * msg,
 *    unsigned long long mlen,
 *    const unsigned char * nonce,
 *    const unsigned char * pk,
 *    const unsigned char * sk)
 *
 * Parameters:
 *    [out] ctxt    the buffer for the cipher-text.
 *    [in]  msg     the message to be encrypted.
 *    [in]  mlen    the length of msg.
 *    [in]  nonce   a randomly generated nonce.
 *    [in]  pk      the receivers public key, used for encryption.
 *    [in]  sk      the senders private key, used for signing.
 *
 * Returns:
 *    0 if operation is successful.
 *
 * Precondition:
 *    the nonce must have size crypto_box_NONCEBYTES.
 *
 * Postcondition:
 *    first mlen bytes of ctxt will contain the ciphertext.
 */
NAN_METHOD(bind_crypto_box_easy) {
    Nan::EscapableHandleScope scope;

    ARGS(4,"arguments message, nonce, publicKey and secretKey must be buffers");
    ARG_TO_UCHAR_BUFFER(message);
    ARG_TO_UCHAR_BUFFER_LEN(nonce, crypto_box_NONCEBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(publicKey, crypto_box_PUBLICKEYBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(secretKey, crypto_box_SECRETKEYBYTES);

    // The ciphertext will include the mac.
    NEW_BUFFER_AND_PTR(ctxt, message_size + crypto_box_MACBYTES);

    if (crypto_box_easy(ctxt_ptr, message, message_size, nonce, publicKey, secretKey) == 0) {
        return info.GetReturnValue().Set(ctxt);
    } else {
        return;
    }
}


/**
 * Randomly generates a secret key and a corresponding public key.
 *
 * int crypto_box_keypair(
 *    unsigned char * pk,
 *    unsigned char * sk)
 *
 * Parameters:
 *    [out] pk  the buffer for the public key with length crypto_box_PUBLICKEYBYTES
 *    [out] sk  the buffer for the private key with length crypto_box_SECRETKEYTBYTES
 *
 * Returns:
 *    0 if generation successful.
 *
 * Precondition:
 *    the buffer for pk must be at least crypto_box_PUBLICKEYBYTES in length
 *    the buffer for sk must be at least crypto_box_SECRETKEYTBYTES in length
 *
 * Postcondition:
 *    first crypto_box_PUBLICKEYTBYTES of pk will be the key data.
 *    first crypto_box_SECRETKEYTBYTES of sk will be the key data.
 */
NAN_METHOD(bind_crypto_box_keypair) {
    Nan::EscapableHandleScope scope;

    NEW_BUFFER_AND_PTR(pk, crypto_box_PUBLICKEYBYTES);
    NEW_BUFFER_AND_PTR(sk, crypto_box_SECRETKEYBYTES);

    if (crypto_box_keypair(pk_ptr, sk_ptr) == 0) {
        Local<Object> result = Nan::New<Object>();
        
        JS_OBJECT_SET_PROPERTY(result, "publicKey", pk);
        JS_OBJECT_SET_PROPERTY(result, "secretKey", sk);

        return JS_OBJECT(result);
    } else {
        return;
    }
}

/**
 * Decrypts a ciphertext ctxt given the receivers private key, and senders public key.
 *
 * int crypto_box_open(
 *    unsigned char *       msg,
 *    const unsigned char * ctxt,
 *    unsigned long long    clen,
 *    const unsigned char * nonce,
 *    const unsigned char * pk,
 *    const unsigned char * sk)
 *
 * Parameters:
 *     [out] msg     the buffer to place resulting plaintext.
 *     [in]  ctxt    the ciphertext to be decrypted.
 *     [in]  clen    the length of the ciphertext.
 *     [in]  nonce   a randomly generated.
 *     [in]  pk      the senders public key, used for verification.
 *     [in]  sk      the receivers private key, used for decryption.
 *
 Returns:
 *     0 if successful and -1 if verification fails.
 *
 Precondition:
 *     first crypto_box_BOXZEROBYTES of ctxt be all 0.
 *     the nonce must have size crypto_box_NONCEBYTES.
 *
 * Postcondition:
 *     first clen bytes of msg will contain the plaintext.
 *     first crypto_box_ZEROBYTES of msg will be all 0.
 */
NAN_METHOD(bind_crypto_box_open) {
    Nan::EscapableHandleScope scope;

    ARGS(4,"arguments cipherText, nonce, publicKey and secretKey must be buffers");
    ARG_TO_UCHAR_BUFFER(cipherText);
    ARG_TO_UCHAR_BUFFER_LEN(nonce, crypto_box_NONCEBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(publicKey, crypto_box_PUBLICKEYBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(secretKey, crypto_box_SECRETKEYBYTES);

    // API requires that the first crypto_box_BOXZEROBYTES of msg be 0 so lets check
    if (cipherText_size < crypto_box_BOXZEROBYTES) {
        std::ostringstream oss;
        oss << "argument cipherText must have a length of at least " << crypto_box_BOXZEROBYTES << " bytes";
        return Nan::ThrowError(oss.str().c_str());
    }

    unsigned int i;

    for (i = 0; i < crypto_box_BOXZEROBYTES; i++) {
        if( cipherText[i] ) break;
    }

    if (i < crypto_box_BOXZEROBYTES) {
        std::ostringstream oss;
        oss << "the first " << crypto_box_BOXZEROBYTES << " bytes of argument cipherText must be 0";
        return Nan::ThrowError(oss.str().c_str());
    }

    NEW_BUFFER_AND_PTR(msg, cipherText_size);

    if (crypto_box_open(msg_ptr, cipherText, cipherText_size, nonce, publicKey, secretKey) == 0) {

        // Remove the padding at the beginning of the message
        NEW_BUFFER_AND_PTR(plain_text, cipherText_size - crypto_box_ZEROBYTES);
        memcpy(plain_text_ptr,(void*) (msg_ptr + crypto_box_ZEROBYTES), cipherText_size - crypto_box_ZEROBYTES);

        return info.GetReturnValue().Set(plain_text);
    } else {
        return;
    }
}

/**
 * Decrypts a ciphertext ctxt given the receivers private key, and senders public key.
 *
 * int crypto_box_open_easy(
 *    unsigned char *       msg,
 *    const unsigned char * ctxt,
 *    unsigned long long    clen,
 *    const unsigned char * nonce,
 *    const unsigned char * pk,
 *    const unsigned char * sk)
 *
 * Parameters:
 *     [out] msg     the buffer to place resulting plaintext.
 *     [in]  ctxt    the ciphertext to be decrypted.
 *     [in]  clen    the length of the ciphertext.
 *     [in]  nonce   a randomly generated.
 *     [in]  pk      the senders public key, used for verification.
 *     [in]  sk      the receivers private key, used for decryption.
 *
 Returns:
 *     0 if successful and -1 if verification fails.
 *
 Precondition:
 *     the nonce must have size crypto_box_NONCEBYTES.
 *
 * Postcondition:
 *     first clen bytes of msg will contain the plaintext.
 */
NAN_METHOD(bind_crypto_box_open_easy) {
    Nan::EscapableHandleScope scope;

    ARGS(4,"arguments cipherText, nonce, publicKey and secretKey must be buffers");
    ARG_TO_UCHAR_BUFFER(cipherText);
    ARG_TO_UCHAR_BUFFER_LEN(nonce, crypto_box_NONCEBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(publicKey, crypto_box_PUBLICKEYBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(secretKey, crypto_box_SECRETKEYBYTES);

    // cipherText should have crypto_box_MACBYTES + encrypted message chars so lets check
    if (cipherText_size < crypto_box_MACBYTES) {
        std::ostringstream oss;
        oss << "argument cipherText must have a length of at least " << crypto_box_MACBYTES << " bytes";
        return Nan::ThrowError(oss.str().c_str());
    }

    NEW_BUFFER_AND_PTR(msg, cipherText_size - crypto_box_MACBYTES);

    if( crypto_box_open_easy(msg_ptr, cipherText, cipherText_size, nonce, publicKey, secretKey) == 0) {
        return info.GetReturnValue().Set(msg);
    } else {
        return;
    }
}

/**
 * Partially performs the computation required for both encryption and decryption of data.
 *
 * int crypto_box_beforenm(
 *    unsigned char*        k,
 *    const unsigned char*  pk,
 *    const unsigned char*  sk)
 *
 * Parameters:
 *    [out] k   the result of the computation.
 *    [in]  pk  the receivers public key, used for encryption.
 *    [in]  sk  the senders private key, used for signing.
 *
 * The intermediate data computed by crypto_box_beforenm is suitable for both
 * crypto_box_afternm and crypto_box_open_afternm, and can be reused for any
 * number of messages.
 */
NAN_METHOD(bind_crypto_box_beforenm) {
    Nan::EscapableHandleScope scope;

    ARGS(2,"arguments publicKey, and secretKey must be buffers");
    ARG_TO_UCHAR_BUFFER_LEN(publicKey, crypto_box_PUBLICKEYBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(secretKey, crypto_box_SECRETKEYBYTES);

    NEW_BUFFER_AND_PTR(k, crypto_box_BEFORENMBYTES);

    if( crypto_box_beforenm(k_ptr, publicKey, secretKey) != 0) {
      return Nan::ThrowError("crypto_box_beforenm failed");
    }

    return info.GetReturnValue().Set(k);
}

/**
 * Encrypts a given a message m, using partial computed data.
 *
 * int crypto_box_afternm(
 *    unsigned char * ctxt,
 *       const unsigned char * msg,
 *       unsigned long long mlen,
 *       const unsigned char * nonce,
 *       const unsigned char * k)
 *
 * Parameters:
 *    [out] ctxt   the buffer for the cipher-text.
 *    [in]  msg    the message to be encrypted.
 *    [in]  mlen   the length of msg.
 *    [in]  nonce  a randomly generated nonce.
 *    [in]  k      the partial computed data.
 *
 * Returns:
 *    0 if operation is successful.
 */
NAN_METHOD(bind_crypto_box_afternm) {
    Nan::EscapableHandleScope scope;

    ARGS(3,"arguments message, nonce and k must be buffers");
    ARG_TO_UCHAR_BUFFER(message);
    ARG_TO_UCHAR_BUFFER_LEN(nonce, crypto_box_NONCEBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(k, crypto_box_BEFORENMBYTES);

    // Pad the message with crypto_box_ZEROBYTES zeros
    NEW_BUFFER_AND_PTR(msg, message_size + crypto_box_ZEROBYTES);

    unsigned int i;
    for(i = 0; i < crypto_box_ZEROBYTES; i++) {
       msg_ptr[i] = 0U;
    }

    //Copy the message to the new buffer
    memcpy((void*) (msg_ptr + crypto_box_ZEROBYTES), (void *) message, message_size);
    message_size += crypto_box_ZEROBYTES;

    NEW_BUFFER_AND_PTR(ctxt, message_size);

    if (crypto_box_afternm(ctxt_ptr, msg_ptr, message_size, nonce, k) == 0) {
        return info.GetReturnValue().Set(ctxt);
    } else {
        return;
    }
}

/**
 * Decrypts a ciphertext ctxt given the receivers private key, and senders public key.
 *
 * int crypto_box_open_afternm ( unsigned char * msg,
 *    const unsigned char * ctxt,
 *    unsigned long long clen,
 *    const unsigned char * nonce,
 *    const unsigned char * k)
 *
 * Parameters:
 *    [out] msg    the buffer to place resulting plaintext.
 *    [in]  ctxt   the ciphertext to be decrypted.
 *    [in]  clen   the length of the ciphertext.
 *    [in]  nonce  a randomly generated nonce.
 *    [in]  k      the partial computed data.
 *
 * Returns:
 *    0 if successful and -1 if verification fails.
 *
 * Precondition:
 *    first crypto_box_BOXZEROBYTES of ctxt be all 0.
 *    the nonce must have size crypto_box_NONCEBYTES.
 *
 * Postcondition:
 *    first clen bytes of msg will contain the plaintext.
 *    first crypto_box_ZEROBYTES of msg will be all 0.
 */
NAN_METHOD(bind_crypto_box_open_afternm) {
    Nan::EscapableHandleScope scope;

    ARGS(3,"arguments cipherText, nonce, k");
    ARG_TO_UCHAR_BUFFER(cipherText);
    ARG_TO_UCHAR_BUFFER_LEN(nonce, crypto_box_NONCEBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(k, crypto_box_BEFORENMBYTES);

    // API requires that the first crypto_box_BOXZEROBYTES of msg be 0 so lets check
    if (cipherText_size < crypto_box_BOXZEROBYTES) {
        std::ostringstream oss;
        oss << "argument cipherText must have a length of at least " << crypto_box_BOXZEROBYTES << " bytes";
        return Nan::ThrowError(oss.str().c_str());
    }

    unsigned int i;
    for(i = 0; i < crypto_box_BOXZEROBYTES; i++) {
        if( cipherText[i] ) break;
    }

    if (i < crypto_box_BOXZEROBYTES) {
        std::ostringstream oss;
        oss << "the first " << crypto_box_BOXZEROBYTES << " bytes of argument cipherText must be 0";
        return Nan::ThrowError(oss.str().c_str());
    }

    NEW_BUFFER_AND_PTR(msg, cipherText_size);

    if (crypto_box_open_afternm(msg_ptr, cipherText, cipherText_size, nonce, k) == 0) {

        // Remove the padding at the beginning of the message
        NEW_BUFFER_AND_PTR(plain_text,cipherText_size - crypto_box_ZEROBYTES);
        memcpy(plain_text_ptr,(void*) (msg_ptr + crypto_box_ZEROBYTES), cipherText_size - crypto_box_ZEROBYTES);

        return info.GetReturnValue().Set(plain_text);
    } else {
        return;
    }
}

/*
int crypto_box_detached(unsigned char *c,
                        unsigned char *mac,
                        const unsigned char *m,
                        unsigned long long mlen,
                        const unsigned char *n,
                        const unsigned char *pk,
                        const unsigned char *sk)
*/
NAN_METHOD(bind_crypto_box_detached) {
    Nan::EscapableHandleScope scope;

    ARGS(5,"arguments mac, message, nonce, and public and private key must be buffers");
    ARG_TO_UCHAR_BUFFER_LEN(mac, crypto_secretbox_MACBYTES);
    ARG_TO_UCHAR_BUFFER(message);
    ARG_TO_UCHAR_BUFFER_LEN(nonce, crypto_secretbox_NONCEBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(pk, crypto_box_PUBLICKEYBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(sk, crypto_box_SECRETKEYBYTES);
    
    NEW_BUFFER_AND_PTR(c, message_size);

    if (crypto_box_detached(c_ptr, mac, message, message_size, nonce, pk, sk) == 0) {
        return info.GetReturnValue().Set(c);
    }
    
    return JS_NULL;
}

/*
 *int crypto_box_open_detached(unsigned char *m,
 *                           const unsigned char *c,
                             const unsigned char *mac,
                             unsigned long long clen,
                             const unsigned char *n,
                             const unsigned char *pk,
                             const unsigned char *sk)

 */
NAN_METHOD(bind_crypto_box_open_detached) {
    Nan::EscapableHandleScope scope;

    ARGS(5,"arguments encrypted message, mac, nonce, and key must be buffers");
    ARG_TO_UCHAR_BUFFER(c);
    ARG_TO_UCHAR_BUFFER_LEN(mac, crypto_secretbox_MACBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(nonce, crypto_secretbox_NONCEBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(pk, crypto_box_PUBLICKEYBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(sk, crypto_box_SECRETKEYBYTES);

    NEW_BUFFER_AND_PTR(m, c_size);

    if (crypto_box_open_detached(m_ptr, c, mac, c_size, nonce, pk, sk) == 0) {
        return info.GetReturnValue().Set(m);
    }
    
    return JS_NULL;
}

/*
 *int crypto_box_seal(unsigned char *c, const unsigned char *m,
                    unsigned long long mlen, const unsigned char *pk);
 */
NAN_METHOD(bind_crypto_box_seal) {
    Nan::EscapableHandleScope scope;

    ARGS(2,"arguments unencrypted message, and recipient public key must be buffers");
    ARG_TO_UCHAR_BUFFER(message);
    ARG_TO_UCHAR_BUFFER_LEN(pk, crypto_box_PUBLICKEYBYTES);

    NEW_BUFFER_AND_PTR(c, message_size + crypto_box_SEALBYTES);

    if (crypto_box_seal(c_ptr, message, message_size, pk) == 0) {
        return info.GetReturnValue().Set(c);
    }
    
    return JS_NULL;
}

/*
 *int crypto_box_seal_open(unsigned char *m, const unsigned char *c,
                         unsigned long long clen,
                         const unsigned char *pk, const unsigned char *sk)
 */
NAN_METHOD(bind_crypto_box_seal_open) {
    Nan::EscapableHandleScope scope;

    ARGS(3,"arguments encrypted message, recipient public key, and recipient secret key must be buffers");
    ARG_TO_UCHAR_BUFFER(c);
    ARG_TO_UCHAR_BUFFER_LEN(pk, crypto_box_PUBLICKEYBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(sk, crypto_box_SECRETKEYBYTES);
    
    NEW_BUFFER_AND_PTR(m, c_size - crypto_box_SEALBYTES);

    if (crypto_box_seal_open(m_ptr, c, c_size, pk, sk) == 0) {
        return info.GetReturnValue().Set(m);
    }
    
    return JS_NULL;
}

/*
 *int crypto_box_seed_keypair(unsigned char *pk, unsigned char *sk,
                            const unsigned char *seed);
 */
NAN_METHOD(bind_crypto_box_seed_keypair) {
    Nan::EscapableHandleScope scope;

    ARGS(1,"argument seed must be a buffer");
    ARG_TO_UCHAR_BUFFER_LEN(seed, crypto_box_SEEDBYTES);
    
    NEW_BUFFER_AND_PTR(pk, crypto_box_PUBLICKEYBYTES);
    NEW_BUFFER_AND_PTR(sk, crypto_box_SECRETKEYBYTES);

    if (crypto_box_seed_keypair(pk_ptr, sk_ptr, seed) == 0) {
        Local<Object> result = Nan::New<Object>();

        JS_OBJECT_SET_PROPERTY(result, "publicKey", pk);
        JS_OBJECT_SET_PROPERTY(result, "secretKey", sk);

        return JS_OBJECT(result);
    }
    
    return JS_NULL;
}

/*
int crypto_box_detached_afternm(unsigned char *c, unsigned char *mac,
                                const unsigned char *m, unsigned long long mlen,
                                const unsigned char *n, const unsigned char *k);
*/
NAN_METHOD(bind_crypto_box_detached_afternm) {
    Nan::EscapableHandleScope scope;

    ARGS(4,"arguments message, nonce and k must be buffers");
    ARG_TO_UCHAR_BUFFER(message);
    ARG_TO_UCHAR_BUFFER_LEN(mac, crypto_box_MACBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(nonce, crypto_box_NONCEBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(k, crypto_box_BEFORENMBYTES);

    // Pad the message with crypto_box_ZEROBYTES zeros
    NEW_BUFFER_AND_PTR(ctxt, message_size);

    if (crypto_box_detached_afternm(ctxt_ptr, mac, message, message_size, nonce, k) == 0) {
        return info.GetReturnValue().Set(ctxt);
    }
    
    return JS_NULL;   
}

/*
int crypto_box_open_detached_afternm(unsigned char *m, const unsigned char *c,
                                     const unsigned char *mac,
                                     unsigned long long clen, const unsigned char *n,
                                     const unsigned char *k)
*/
NAN_METHOD(bind_crypto_box_open_detached_afternm) {
    Nan::EscapableHandleScope scope;

    ARGS(4,"arguments message, nonce and k must be buffers");
    ARG_TO_UCHAR_BUFFER(ctxt);
    ARG_TO_UCHAR_BUFFER_LEN(mac, crypto_box_MACBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(nonce, crypto_box_NONCEBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(k, crypto_box_BEFORENMBYTES);

    // Pad the message with crypto_box_ZEROBYTES zeros
    NEW_BUFFER_AND_PTR(message, ctxt_size);

    if (crypto_box_open_detached_afternm(message_ptr, ctxt, mac, ctxt_size, nonce, k) == 0) {
        return info.GetReturnValue().Set(message);
    }
    
    return JS_NULL;   
}

/*
 int crypto_box_easy_afternm(unsigned char *c, const unsigned char *m,
                            unsigned long long mlen, const unsigned char *n,
                            const unsigned char *k);
*/
NAN_METHOD(bind_crypto_box_easy_afternm) {
    Nan::EscapableHandleScope scope;

    ARGS(3,"arguments message, nonce and k must be buffers");
    ARG_TO_UCHAR_BUFFER(message);
    ARG_TO_UCHAR_BUFFER_LEN(nonce, crypto_box_NONCEBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(k, crypto_box_BEFORENMBYTES);

    // The ciphertext will include the mac.
    NEW_BUFFER_AND_PTR(ctxt, crypto_box_MACBYTES + message_size);

    if (crypto_box_easy_afternm(ctxt_ptr, message, message_size, nonce, k) == 0) {
        return info.GetReturnValue().Set(ctxt);
    }
    
    return JS_NULL;   
}

/*
int crypto_box_open_easy_afternm(unsigned char *m, const unsigned char *c,
                                 unsigned long long clen, const unsigned char *n,
                                 const unsigned char *k)
*/
NAN_METHOD(bind_crypto_box_open_easy_afternm) {
    Nan::EscapableHandleScope scope;

    ARGS(3,"arguments message, nonce and k must be buffers");
    ARG_TO_UCHAR_BUFFER(ctxt);
    ARG_TO_UCHAR_BUFFER_LEN(nonce, crypto_box_NONCEBYTES);
    ARG_TO_UCHAR_BUFFER_LEN(k, crypto_box_BEFORENMBYTES);

    // cipherText should have crypto_box_MACBYTES + encrypted message chars so lets check
    if (ctxt_size < crypto_box_MACBYTES) {
        std::ostringstream oss;
        oss << "argument cipherText must have a length of at least " << crypto_box_MACBYTES << " bytes";
        return Nan::ThrowError(oss.str().c_str());
    }

    NEW_BUFFER_AND_PTR(message, ctxt_size - crypto_box_MACBYTES);

    if (crypto_box_open_easy_afternm(message_ptr, ctxt, ctxt_size, nonce, k) == 0) {
        return info.GetReturnValue().Set(message);
    }
    
    return JS_NULL;   
}



/**
 * Register function calls in node binding
 */
void register_crypto_box(Handle<Object> target) {
     // Box
    NEW_METHOD(crypto_box);
    NEW_METHOD(crypto_box_keypair);
    
    NEW_METHOD(crypto_box_easy);
    NEW_METHOD(crypto_box_easy_afternm);
    
    NEW_METHOD(crypto_box_beforenm);
    NEW_METHOD(crypto_box_afternm);
    NEW_METHOD(crypto_box_seed_keypair);
    
    NEW_METHOD(crypto_box_detached);
    NEW_METHOD(crypto_box_detached_afternm);
    
    NEW_METHOD(crypto_box_open);
    NEW_METHOD(crypto_box_open_afternm);
    NEW_METHOD(crypto_box_open_easy);
    NEW_METHOD(crypto_box_open_detached);
    NEW_METHOD(crypto_box_open_detached_afternm);
    NEW_METHOD(crypto_box_open_easy_afternm);
    
    NEW_METHOD(crypto_box_seal);
    NEW_METHOD(crypto_box_seal_open);
    
    NEW_INT_PROP(crypto_box_NONCEBYTES);
    NEW_INT_PROP(crypto_box_MACBYTES);
    NEW_INT_PROP(crypto_box_BEFORENMBYTES);
    NEW_INT_PROP(crypto_box_BOXZEROBYTES);
    NEW_INT_PROP(crypto_box_PUBLICKEYBYTES);
    NEW_INT_PROP(crypto_box_SECRETKEYBYTES);
    NEW_INT_PROP(crypto_box_ZEROBYTES);
    NEW_INT_PROP(crypto_box_SEEDBYTES);
    NEW_INT_PROP(crypto_box_SEALBYTES);
    NEW_STRING_PROP(crypto_box_PRIMITIVE);
}
