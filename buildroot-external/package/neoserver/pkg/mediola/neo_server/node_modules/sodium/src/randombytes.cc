/**
 * Node Native Module for Lib Sodium
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */
#include "node_sodium.h"

// Generating Random Data
// Docs: https://download.libsodium.org/doc/generating_random_data/index.html

// Lib Sodium Random

// void randombytes_buf(void *const buf, const size_t size)
NAN_METHOD(bind_randombytes_buf) {
    Nan::EscapableHandleScope scope;

    ARGS(1, "argument must be a buffer");
    ARG_TO_VOID_BUFFER(buffer);

    randombytes_buf(buffer, buffer_size);
    return JS_NULL;
}

// void randombytes_stir()
NAN_METHOD(bind_randombytes_stir) {
    Nan::EscapableHandleScope scope;
    randombytes_stir();

    return JS_NULL;
}

NAN_METHOD(bind_randombytes_close) {
    Nan::EscapableHandleScope scope;

    // int randombytes_close()
    return JS_INTEGER(randombytes_close());
}

NAN_METHOD(bind_randombytes_random) {
    Nan::EscapableHandleScope scope;

    // uint_32 randombytes_random()
    return JS_UINT32(randombytes_random());
}

NAN_METHOD(bind_randombytes_uniform) {
    Nan::EscapableHandleScope scope;

    ARGS(1, "argument size must be a positive number");
    ARG_TO_NUMBER(upper_bound);

    if (upper_bound <= 0) {
        return Nan::ThrowError("argument size must be a positive number");
    }

    // uint32_t randombytes_uniform(const uint32_t upper_bound)
    return JS_UINT32(randombytes_uniform(upper_bound));
}

NAN_METHOD(bind_randombytes_buf_deterministic) {
     Nan::EscapableHandleScope scope;

    ARGS(2,"arguments buf and seed must be buffers");

    ARG_TO_UCHAR_BUFFER(buffer);
    ARG_TO_UCHAR_BUFFER_LEN(seed, randombytes_SEEDBYTES);
    randombytes_buf_deterministic(buffer, buffer_size, seed);

    return JS_NULL;
}

/**
 * Register function calls in node binding
 */
void register_randombytes(Handle<Object> target) {
   
    NEW_METHOD(randombytes_buf);
    Nan::SetMethod(target, "randombytes", bind_randombytes_buf);
    NEW_METHOD(randombytes_close);
    NEW_METHOD(randombytes_stir);
    NEW_METHOD(randombytes_random);
    NEW_METHOD(randombytes_uniform);
    NEW_METHOD(randombytes_buf_deterministic);

    NEW_INT_PROP(randombytes_SEEDBYTES);
}