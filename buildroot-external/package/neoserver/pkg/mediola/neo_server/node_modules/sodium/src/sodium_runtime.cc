/**
 * Node Native Module for Lib Sodium
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */
#include "node_sodium.h"

// int sodium_runtime_has_aesni(void);
NAN_METHOD(bind_sodium_runtime_has_aesni) {
    Nan::EscapableHandleScope scope;
    return info.GetReturnValue().Set(
        Nan::New<Integer>(sodium_runtime_has_aesni())
    );
}

//int sodium_runtime_has_neon(void);
NAN_METHOD(bind_sodium_runtime_has_neon) {
    Nan::EscapableHandleScope scope;
    return info.GetReturnValue().Set(
        Nan::New<Integer>(sodium_runtime_has_neon())
    );
}

//int sodium_runtime_has_sse2(void);
NAN_METHOD(bind_sodium_runtime_has_sse2) {
    Nan::EscapableHandleScope scope;
    return info.GetReturnValue().Set(
        Nan::New<Integer>(sodium_runtime_has_sse2())
    );
}

//int sodium_runtime_has_sse3(void);
NAN_METHOD(bind_sodium_runtime_has_sse3) {
    Nan::EscapableHandleScope scope;
    return info.GetReturnValue().Set(
        Nan::New<Integer>(sodium_runtime_has_sse3())
    );
}

//int sodium_runtime_has_ssse3(void);
NAN_METHOD(bind_sodium_runtime_has_ssse3) {
    Nan::EscapableHandleScope scope;
    return info.GetReturnValue().Set(
        Nan::New<Integer>(sodium_runtime_has_ssse3())
    );
}

//int sodium_runtime_has_sse41(void);
NAN_METHOD(bind_sodium_runtime_has_sse41) {
    Nan::EscapableHandleScope scope;
    return info.GetReturnValue().Set(
        Nan::New<Integer>(sodium_runtime_has_sse41())
    );
}

//int sodium_runtime_has_avx(void);
NAN_METHOD(bind_sodium_runtime_has_avx) {
    Nan::EscapableHandleScope scope;
    return info.GetReturnValue().Set(
        Nan::New<Integer>(sodium_runtime_has_avx())
    );
}

//int sodium_runtime_has_avx2(void);
NAN_METHOD(bind_sodium_runtime_has_avx2) {
    Nan::EscapableHandleScope scope;
    return info.GetReturnValue().Set(
        Nan::New<Integer>(sodium_runtime_has_avx2())
    );
}

//int sodium_runtime_has_pclmul(void);
NAN_METHOD(bind_sodium_runtime_has_pclmul) {
    Nan::EscapableHandleScope scope;
    return info.GetReturnValue().Set(
        Nan::New<Integer>(sodium_runtime_has_pclmul())
    );
}

/**
 * Register function calls in node binding
 */
void register_runtime(Handle<Object> target) {
    NEW_METHOD(sodium_runtime_has_aesni);
    NEW_METHOD(sodium_runtime_has_avx);
    NEW_METHOD(sodium_runtime_has_avx2);
    NEW_METHOD(sodium_runtime_has_neon);
    NEW_METHOD(sodium_runtime_has_pclmul);
    NEW_METHOD(sodium_runtime_has_sse2);
    NEW_METHOD(sodium_runtime_has_sse3);
    NEW_METHOD(sodium_runtime_has_sse41);
    NEW_METHOD(sodium_runtime_has_ssse3);
}