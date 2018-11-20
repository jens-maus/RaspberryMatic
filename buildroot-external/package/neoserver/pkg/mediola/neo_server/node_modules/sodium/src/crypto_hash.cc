/**
 * Node Native Module for Lib Sodium
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */
#include "node_sodium.h"

/**
 * int crypto_hash(
 *    unsigned char * hbuf,
 *    const unsigned char * msg,
 *    unsigned long long mlen)
 */
NAN_METHOD(bind_crypto_hash) {
    Nan::EscapableHandleScope scope;

    NUMBER_OF_MANDATORY_ARGS(1,"argument message must be a buffer");

    GET_ARG_AS_UCHAR(0,msg);

    NEW_BUFFER_AND_PTR(hash, crypto_hash_BYTES);

    if( crypto_hash(hash_ptr, msg, msg_size) == 0 ) {
        return info.GetReturnValue().Set(hash);
    } else {
        return JS_NULL;
    }
}

/**
 * Register function calls in node binding
 */
void register_crypto_hash(Handle<Object> target) {
    
    // Hash
    NEW_METHOD(crypto_hash);
    NEW_INT_PROP(crypto_hash_BYTES);
    //NEW_INT_PROP(crypto_hash_BLOCKBYTES);
    NEW_STRING_PROP(crypto_hash_PRIMITIVE);   
}