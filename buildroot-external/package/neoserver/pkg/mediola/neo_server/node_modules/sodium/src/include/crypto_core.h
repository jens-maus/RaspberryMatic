/**
 * Node Native Module for Lib Sodium
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */
#ifndef __CRYPTO_CORE_H__
#define __CRYPTO_CORE_H__

#define CRYPTO_CORE_DEF(ALGO) \
    NAN_METHOD(bind_crypto_core_##ALGO) { \
        Nan::EscapableHandleScope scope; \
        ARGS(3,"arguments are: input buffer, key buffer, c constant buffer"); \
        ARG_TO_UCHAR_BUFFER_LEN(in, crypto_core_ ## ALGO ## _INPUTBYTES); \
        ARG_TO_UCHAR_BUFFER_LEN(key, crypto_core_ ## ALGO ## _KEYBYTES); \
        ARG_TO_UCHAR_BUFFER_LEN_OR_NULL(c, crypto_core_ ## ALGO ## _CONSTBYTES); \
        NEW_BUFFER_AND_PTR(out, crypto_core_ ## ALGO ## _OUTPUTBYTES); \
        if (crypto_core_ ## ALGO (out_ptr, in, key, c) == 0) { \
            return info.GetReturnValue().Set(out); \
        } \
        return JS_NULL; \
    }

#define METHOD_AND_PROPS(ALGO) \
    NEW_METHOD(crypto_core_ ## ALGO); \
    NEW_INT_PROP(crypto_core_ ## ALGO ## _CONSTBYTES); \
    NEW_INT_PROP(crypto_core_ ## ALGO ## _INPUTBYTES); \
    NEW_INT_PROP(crypto_core_ ## ALGO ## _KEYBYTES); \
    NEW_INT_PROP(crypto_core_ ## ALGO ## _OUTPUTBYTES)  

#endif