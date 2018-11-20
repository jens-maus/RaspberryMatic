/**
 * Node Native Module for Lib Sodium
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */
#include "node_sodium.h"

// Lib Sodium Version Functions
NAN_METHOD(bind_sodium_version_string) {
    Nan::EscapableHandleScope scope;

    return info.GetReturnValue().Set(Nan::New<String>(sodium_version_string()).ToLocalChecked());
}

NAN_METHOD(bind_sodium_library_version_minor) {
    Nan::EscapableHandleScope scope;

    return info.GetReturnValue().Set(
        Nan::New(sodium_library_version_minor())
    );
}

NAN_METHOD(bind_sodium_library_version_major) {
    Nan::EscapableHandleScope scope;

    return info.GetReturnValue().Set(
        Nan::New(sodium_library_version_major())
    );
}

// Lib Sodium Utils
NAN_METHOD(bind_memzero) {
    Nan::EscapableHandleScope scope;

    ARGS(1,"argument must be a buffer");
    ARG_TO_VOID_BUFFER(buffer);
    
    sodium_memzero(buffer, buffer_size);
    return JS_NULL;
}

/**
 * int sodium_memcmp(const void * const b1_, const void * const b2_, size_t size);
 */
NAN_METHOD(bind_memcmp) {
    Nan::EscapableHandleScope scope;

    ARGS(3,"arguments must be: buffer, buffer, positive number");

    ARG_TO_VOID_BUFFER(buffer_1);
    ARG_TO_VOID_BUFFER(buffer_2);
    ARG_TO_NUMBER(size);
    
    size_t s = (buffer_1_size < buffer_2_size)? buffer_1_size : buffer_2_size;

    if( s < size ) {
        size = s;
    }

    return info.GetReturnValue().Set(
        Nan::New<Integer>(sodium_memcmp(buffer_1, buffer_2, size))
    );
}

/**
 * char *sodium_bin2hex(char * const hex, const size_t hexlen,
 *                    const unsigned char *bin, const size_t binlen);
 */
NAN_METHOD(bind_bin2hex) {
    Nan::HandleScope scope;

    return Nan::ThrowError("use node's native Buffer.toString()");
}

NAN_METHOD(bind_hex2bin) {
    Nan::HandleScope scope;

    return Nan::ThrowError("use node's native Buffer.toString()");
}

NAN_METHOD(bind_crypto_verify_16) {
    Nan::EscapableHandleScope scope;

    ARGS(2,"arguments must be two buffers");
    ARG_TO_UCHAR_BUFFER_LEN(string1, crypto_verify_16_BYTES);
    ARG_TO_UCHAR_BUFFER_LEN(string2, crypto_verify_16_BYTES);

    return info.GetReturnValue().Set(
        Nan::New<Integer>(crypto_verify_16(string1, string2))
    );
}

// int crypto_verify_16(const unsigned char * string1, const unsigned char * string2)
NAN_METHOD(bind_crypto_verify_32) {
    Nan::EscapableHandleScope scope;

    ARGS(2,"arguments must be two buffers");
    ARG_TO_UCHAR_BUFFER_LEN(string1, crypto_verify_32_BYTES);
    ARG_TO_UCHAR_BUFFER_LEN(string2, crypto_verify_32_BYTES);

    return info.GetReturnValue().Set(
        Nan::New<Integer>(crypto_verify_32(string1, string2))
    );
}

// int crypto_verify_64(const unsigned char * string1, const unsigned char * string2)
NAN_METHOD(bind_crypto_verify_64) {
    Nan::EscapableHandleScope scope;

    ARGS(2,"arguments must be two buffers");
    ARG_TO_UCHAR_BUFFER_LEN(string1, crypto_verify_64_BYTES);
    ARG_TO_UCHAR_BUFFER_LEN(string2, crypto_verify_64_BYTES);

    return info.GetReturnValue().Set(
        Nan::New<Integer>(crypto_verify_64(string1, string2))
    );
}

/**
 * void sodium_increment(unsigned char *n, const size_t nlen);
 *
 */
NAN_METHOD(bind_increment) {
    Nan::EscapableHandleScope scope;

    ARGS(1,"argument must be a buffer");
    ARG_TO_UCHAR_BUFFER(buffer);
    
    sodium_increment(buffer, buffer_size);

    return JS_NULL;
}

/**
 * int sodium_compare(const unsigned char *b1_, const unsigned char *b2, size_t len);
 */
NAN_METHOD(bind_compare) {
    Nan::EscapableHandleScope scope;

    ARGS(2,"arguments must be two buffers");
    ARG_TO_UCHAR_BUFFER(buffer_1);
    ARG_TO_UCHAR_BUFFER(buffer_2);

    if( buffer_1_size != buffer_2_size ) {
        return Nan::ThrowError("buffers need to be the same size");
    }

    return info.GetReturnValue().Set(
        Nan::New<Integer>(sodium_compare(buffer_1, buffer_2, buffer_1_size))
    );
}

/**
 * void sodium_add(unsigned char *a, const unsigned char *b, const size_t len);
 */
NAN_METHOD(bind_add) {
    Nan::EscapableHandleScope scope;

    ARGS(2,"arguments must be two buffers");
    ARG_TO_UCHAR_BUFFER(buffer_1);
    ARG_TO_UCHAR_BUFFER(buffer_2);

    if( buffer_1_size != buffer_2_size ) {
        return Nan::ThrowError("buffers need to be the same size");
    }
    sodium_add(buffer_1, buffer_2, buffer_1_size);
    return JS_NULL;
}

/**
 * `int sodium_is_zero(const unsigned char *n, const size_t nlen);
 */
NAN_METHOD(bind_is_zero) {
    Nan::EscapableHandleScope scope;

    ARGS(1,"argument must be a buffer");
    ARG_TO_UCHAR_BUFFER(buffer_1);

    return info.GetReturnValue().Set(
        Nan::New<Integer>(sodium_is_zero(buffer_1, buffer_1_size))
    );
}

/**
 * Register function calls in node binding
 */
void register_helpers(Handle<Object> target) {
    // Register version functions
    NEW_METHOD(sodium_version_string);
    NEW_METHOD(sodium_library_version_minor);
    NEW_METHOD(sodium_library_version_major);
    
    // Constant-time test for equality
    NEW_METHOD(memcmp);
    NEW_METHOD(memzero);

    // String comparisons
    NEW_METHOD(crypto_verify_16);
    NEW_METHOD(crypto_verify_32);
    NEW_METHOD(crypto_verify_64);
    NEW_INT_PROP(crypto_verify_16_BYTES);
    NEW_INT_PROP(crypto_verify_32_BYTES);
    NEW_INT_PROP(crypto_verify_64_BYTES);
    
    // Hexadecimal encoding/decoding
    NEW_METHOD(bin2hex);
    NEW_METHOD(hex2bin);
    
    // Large Numbers
    NEW_METHOD(increment);
    NEW_METHOD(add);
    NEW_METHOD(compare);
    NEW_METHOD(is_zero);
}