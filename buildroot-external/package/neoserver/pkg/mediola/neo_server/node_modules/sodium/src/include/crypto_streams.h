/**
 * Node Native Module for Lib Sodium
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */
#ifndef __CRYPTO_STREAMS_H__
#define __CRYPTO_STREAMS_H__

#define CRYPTO_STREAM_DEF(ALGO) \
    NAN_METHOD(bind_crypto_stream_##ALGO) { \
        Nan::EscapableHandleScope scope; \
        ARGS(3,"argument length must be a positive number, arguments nonce, and key must be buffers"); \
        ARG_TO_NUMBER(slen); \
        ARG_TO_UCHAR_BUFFER_LEN(nonce, crypto_stream_ ## ALGO ## _NONCEBYTES); \
        ARG_TO_UCHAR_BUFFER_LEN(key, crypto_stream_ ## ALGO ## _KEYBYTES); \
        NEW_BUFFER_AND_PTR(stream, slen); \
        if (crypto_stream_ ## ALGO (stream_ptr, slen, nonce, key) == 0) { \
            return info.GetReturnValue().Set(stream); \
        } \
        return JS_NULL; \
    } \
    NAN_METHOD(bind_crypto_stream_ ## ALGO ## _xor) { \
        Nan::EscapableHandleScope scope; \
        ARGS(3,"arguments message, nonce, and key must be buffers"); \
        ARG_TO_UCHAR_BUFFER(message); \
        ARG_TO_UCHAR_BUFFER_LEN(nonce, crypto_stream_ ## ALGO ## _NONCEBYTES); \
        ARG_TO_UCHAR_BUFFER_LEN(key, crypto_stream_ ## ALGO ## _KEYBYTES); \
        NEW_BUFFER_AND_PTR(ctxt, message_size); \
        if (crypto_stream_ ## ALGO ## _xor(ctxt_ptr, message, message_size, nonce, key) == 0) { \
            return info.GetReturnValue().Set(ctxt); \
        } \
        return JS_NULL; \
    }

#define CRYPTO_STREAM_DEF_IC(ALGO) \
    NAN_METHOD(bind_crypto_stream_ ## ALGO ## _xor_ic) { \
        Nan::EscapableHandleScope scope; \
        ARGS(4,"arguments message, nonce, and key must be buffers"); \
        ARG_TO_UCHAR_BUFFER(message); \
        ARG_TO_UCHAR_BUFFER_LEN(nonce, crypto_stream_ ## ALGO ## _NONCEBYTES); \
        ARG_TO_NUMBER(ic); \
        ARG_TO_UCHAR_BUFFER_LEN(key, crypto_stream_ ## ALGO ## _KEYBYTES); \
        NEW_BUFFER_AND_PTR(ctxt, message_size); \
        if (crypto_stream_ ## ALGO ## _xor_ic(ctxt_ptr, message, message_size, nonce, ic, key) == 0) { \
            return info.GetReturnValue().Set(ctxt); \
        } \
        return JS_NULL; \
    }


#define METHODS(ALGO) \
    NEW_METHOD(crypto_stream_ ## ALGO); \
    NEW_METHOD(crypto_stream_ ## ALGO ## _xor);

#define PROPS(ALGO) \
    NEW_INT_PROP(crypto_stream_ ## ALGO ## _KEYBYTES); \
    NEW_INT_PROP(crypto_stream_ ## ALGO ## _NONCEBYTES)

#define NAN_METHODS(ALGO) \
    NAN_METHOD(bind_crypto_stream_ ## ALGO); \
    NAN_METHOD(bind_crypto_stream_ ## ALGO ## _xor);


NAN_METHODS(xsalsa20);
NAN_METHODS(salsa20);
NAN_METHODS(salsa208);
NAN_METHODS(salsa2012);
NAN_METHODS(chacha20);
NAN_METHODS(chacha20_ietf);

#endif