/**
 * Node Native Module for Lib Sodium
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */
#include "node_sodium.h"

/* int crypto_pwhash_argon2i(unsigned char * const out,
                          unsigned long long outlen,
                          const char * const passwd,
                          unsigned long long passwdlen,
                          const unsigned char * const salt,
                          unsigned long long opslimit, size_t memlimit,
                          int alg)
*/
NAN_METHOD(bind_crypto_pwhash_argon2i) {
    Nan::EscapableHandleScope scope;

    ARGS(6,"arguments must be: output buffer, password buffer, salt buffer, oLimit, memLimit, algorithm");

    ARG_TO_BUFFER_TYPE(out, unsigned char*);
    ARG_TO_BUFFER_TYPE(passwd, char*);
    ARG_TO_UCHAR_BUFFER_LEN(salt, crypto_pwhash_argon2i_SALTBYTES);
    ARG_TO_NUMBER(oppLimit);
    ARG_TO_NUMBER(memLimit);
    ARG_TO_NUMBER(alg);

    if (crypto_pwhash_argon2i(out, out_size, passwd, passwd_size, salt, oppLimit, memLimit, alg) == 0) {
        return JS_TRUE;
    }

    return JS_NULL;
}

/* int crypto_pwhash_argon2i_str(char out[crypto_pwhash_argon2i_STRBYTES],
                              const char * const passwd,
                              unsigned long long passwdlen,
                              unsigned long long opslimit, size_t memlimit)
*/
NAN_METHOD(bind_crypto_pwhash_argon2i_str) {
    Nan::EscapableHandleScope scope;

    ARGS(3,"arguments must be: password buffer, oLimit, memLimit");

    ARG_TO_BUFFER_TYPE(passwd, char*);
    ARG_TO_NUMBER(oppLimit);
    ARG_TO_NUMBER(memLimit);

    NEW_BUFFER_AND_PTR(buf, crypto_pwhash_argon2i_STRBYTES);

    if (crypto_pwhash_argon2i_str((char*)buf_ptr, passwd, passwd_size, oppLimit, memLimit) == 0) {
        return JS_BUFFER(buf);
    }

    return JS_FALSE;
}

/* int crypto_pwhash_argon2i_str_verify(const char str[crypto_pwhash_argon2i_STRBYTES],
                                     const char * const passwd,
                                     unsigned long long passwdlen)
*/
NAN_METHOD(bind_crypto_pwhash_argon2i_str_verify) {
    Nan::EscapableHandleScope scope;

    ARGS(2,"arguments must be: pwhash string, password");

    ARG_TO_BUFFER_TYPE(hash, char*);
    ARG_TO_BUFFER_TYPE(passwd, char*);

    if (crypto_pwhash_argon2i_str_verify(hash, passwd, passwd_size) == 0) {
        return JS_TRUE;
    }

    return JS_FALSE;
}

/*
    int crypto_pwhash(unsigned char * const out, unsigned long long outlen,
                  const char * const passwd, unsigned long long passwdlen,
                  const unsigned char * const salt,
                  unsigned long long opslimit, size_t memlimit, int alg)

    Buffer out
    Buffer password
    Buffer salt
    Number oppsLimit
    Number memLimit
    Number algorithm

*/
NAN_METHOD(bind_crypto_pwhash) {
    Nan::EscapableHandleScope scope;

    ARGS(6,"arguments must be: output buffer, password buffer, salt buffer, oLimit, memLimit, algorithm");

    ARG_TO_BUFFER_TYPE(out, unsigned char*);
    ARG_TO_BUFFER_TYPE(passwd, char*);
    ARG_TO_UCHAR_BUFFER_LEN(salt, crypto_pwhash_SALTBYTES);
    ARG_TO_NUMBER(oppLimit);
    ARG_TO_NUMBER(memLimit);
    ARG_TO_NUMBER(alg);

    if (crypto_pwhash(out, out_size, passwd, passwd_size, salt, oppLimit, memLimit, alg) == 0) {
        return JS_TRUE;
    }

    return JS_NULL;
}


/**
 * int crypto_pwhash_str(char out[crypto_pwhash_STRBYTES],
                      const char * const passwd, unsigned long long passwdlen,
                      unsigned long long opslimit, size_t memlimit)

    Buffer out
    Buffer passwd
    Number oppsLimit
    Number memLimit
*/
NAN_METHOD(bind_crypto_pwhash_str) {
    Nan::EscapableHandleScope scope;

    ARGS(3,"arguments must be: password buffer, oLimit, memLimit");

    ARG_TO_BUFFER_TYPE(passwd, char*);
    ARG_TO_NUMBER(oppLimit);
    ARG_TO_NUMBER(memLimit);

    NEW_BUFFER_AND_PTR(out, crypto_pwhash_STRBYTES);

    if (crypto_pwhash_str((char*)out_ptr, passwd, passwd_size, oppLimit, memLimit) == 0) {
        return info.GetReturnValue().Set(out);
    }

    return JS_FALSE;
}

/**
 * int crypto_pwhash_str_verify(const char str[crypto_pwhash_STRBYTES],
                             const char * const passwd,
                             unsigned long long passwdlen)

    Buffer hash String
    Buffer password
 */
NAN_METHOD(bind_crypto_pwhash_str_verify) {
    Nan::EscapableHandleScope scope;

    ARGS(2,"arguments must be: pwhash string, password");

    ARG_TO_UCHAR_BUFFER_LEN(hash, crypto_pwhash_STRBYTES);
    ARG_TO_BUFFER_TYPE(passwd, char*);

    if (crypto_pwhash_str_verify((char*)hash, passwd, passwd_size) == 0) {
        return JS_TRUE;
    }

    return JS_FALSE;
}


/**
 * int crypto_pwhash_scryptsalsa208sha256(unsigned char * const out,
                                       unsigned long long outlen,
                                       const char * const passwd,
                                       unsigned long long passwdlen,
                                       const unsigned char * const salt,
                                       unsigned long long opslimit,
                                       size_t memlimit);

    number out length
    buffer passwd
    buffer salt
    number opslimit
    number memlimit
 */
NAN_METHOD(bind_crypto_pwhash_scryptsalsa208sha256) {
    Nan::EscapableHandleScope scope;

    ARGS(5,"arguments must be: output buffer, password buffer, salt buffer, oLimit, memLimit");

    ARG_TO_BUFFER_TYPE(out, unsigned char*);
    ARG_TO_BUFFER_TYPE(passwd, char*);
    ARG_TO_UCHAR_BUFFER_LEN(salt, crypto_pwhash_scryptsalsa208sha256_SALTBYTES);
    ARG_TO_NUMBER(oppLimit);
    ARG_TO_NUMBER(memLimit);

    if (crypto_pwhash_scryptsalsa208sha256(out, out_size, passwd, passwd_size, salt, oppLimit, memLimit) == 0) {
        return JS_TRUE;
    }

    return JS_FALSE;
}

/**
 * int crypto_pwhash_scryptsalsa208sha256_ll(const uint8_t * passwd, size_t passwdlen,
                                          const uint8_t * salt, size_t saltlen,
                                          uint64_t N, uint32_t r, uint32_t p,
                                          uint8_t * buf, size_t buflen);
 * Buffer passwd
 * Buffer salt
 * Number N
 * Number r
 * Number p
 * Buffer scrypt hash output
 */
NAN_METHOD(bind_crypto_pwhash_scryptsalsa208sha256_ll) {
    Nan::EscapableHandleScope scope;

    ARGS(6,"arguments must be: password buffer, salt buffer, N, r, p, output buffer");

    ARG_TO_BUFFER_TYPE(passwd, uint8_t*);
    ARG_TO_BUFFER_TYPE(salt, uint8_t*);
    ARG_TO_NUMBER(N);
    ARG_TO_NUMBER(r);
    ARG_TO_NUMBER(p);
    ARG_TO_BUFFER_TYPE(out, uint8_t*);

    if (crypto_pwhash_scryptsalsa208sha256_ll(passwd, passwd_size, salt, salt_size, N, r, p, out, out_size) == 0) {
        return JS_TRUE;
    }

    return JS_FALSE;
}

/**
  int crypto_pwhash_scryptsalsa208sha256_str(char out[crypto_pwhash_scryptsalsa208sha256_STRBYTES],
                                           const char * const passwd,
                                           unsigned long long passwdlen,
                                           unsigned long long opslimit,
                                           size_t memlimit);


 */
NAN_METHOD(bind_crypto_pwhash_scryptsalsa208sha256_str) {
    Nan::EscapableHandleScope scope;

    ARGS(3,"arguments must be: password buffer, oLimit, memLimit");

    ARG_TO_BUFFER_TYPE(passwd, char*);
    ARG_TO_NUMBER(oppLimit);
    ARG_TO_NUMBER(memLimit);

    NEW_BUFFER_AND_PTR(hash, crypto_pwhash_scryptsalsa208sha256_STRBYTES);

    if (crypto_pwhash_scryptsalsa208sha256_str((char*)hash_ptr, passwd, passwd_size, oppLimit, memLimit) == 0) {
        return JS_BUFFER(hash);
    }

    return JS_NULL;
}

/**
 * int crypto_pwhash_scryptsalsa208sha256_str_verify(const char str[crypto_pwhash_scryptsalsa208sha256_STRBYTES],
                                                  const char * const passwd,
                                                  unsigned long long passwdlen);
 */
NAN_METHOD(bind_crypto_pwhash_scryptsalsa208sha256_str_verify) {
    Nan::EscapableHandleScope scope;

    ARGS(2,"arguments must be: pwhash string, password");

    ARG_TO_UCHAR_BUFFER_LEN(hash, crypto_pwhash_scryptsalsa208sha256_STRBYTES);
    ARG_TO_BUFFER_TYPE(passwd, char*);

    if (crypto_pwhash_scryptsalsa208sha256_str_verify((char*)hash, passwd, passwd_size) == 0) {
        return JS_TRUE;
    }

    return JS_FALSE;
}


/**
 * Register function calls in node binding
 */
void register_crypto_pwhash(Handle<Object> target) {

    // Methods
    NEW_METHOD(crypto_pwhash);
    NEW_METHOD(crypto_pwhash_str);
    NEW_METHOD(crypto_pwhash_str_verify);
    NEW_METHOD(crypto_pwhash_scryptsalsa208sha256);
    NEW_METHOD(crypto_pwhash_scryptsalsa208sha256_ll);
    NEW_METHOD(crypto_pwhash_scryptsalsa208sha256_str);
    NEW_METHOD(crypto_pwhash_scryptsalsa208sha256_str_verify);
    NEW_METHOD(crypto_pwhash_argon2i);
    NEW_METHOD(crypto_pwhash_argon2i_str);
    NEW_METHOD(crypto_pwhash_argon2i_str_verify);

    // Properties
    NEW_NUMBER_PROP(crypto_pwhash_scryptsalsa208sha256_OPSLIMIT_INTERACTIVE);
    NEW_NUMBER_PROP(crypto_pwhash_scryptsalsa208sha256_MEMLIMIT_INTERACTIVE);
    NEW_NUMBER_PROP(crypto_pwhash_scryptsalsa208sha256_OPSLIMIT_SENSITIVE);
    NEW_NUMBER_PROP(crypto_pwhash_scryptsalsa208sha256_MEMLIMIT_SENSITIVE);
    NEW_INT_PROP(crypto_pwhash_scryptsalsa208sha256_SALTBYTES);
    NEW_INT_PROP(crypto_pwhash_scryptsalsa208sha256_STRBYTES);
    NEW_STRING_PROP(crypto_pwhash_scryptsalsa208sha256_STRPREFIX);

    NEW_NUMBER_PROP(crypto_pwhash_ALG_DEFAULT);
    NEW_NUMBER_PROP(crypto_pwhash_SALTBYTES);
    NEW_NUMBER_PROP(crypto_pwhash_STRBYTES);
    NEW_STRING_PROP(crypto_pwhash_STRPREFIX);
    NEW_NUMBER_PROP(crypto_pwhash_OPSLIMIT_INTERACTIVE);
    NEW_NUMBER_PROP(crypto_pwhash_MEMLIMIT_INTERACTIVE);
    NEW_NUMBER_PROP(crypto_pwhash_OPSLIMIT_MODERATE);
    NEW_NUMBER_PROP(crypto_pwhash_MEMLIMIT_MODERATE);
    NEW_NUMBER_PROP(crypto_pwhash_OPSLIMIT_SENSITIVE);
    NEW_NUMBER_PROP(crypto_pwhash_MEMLIMIT_SENSITIVE);
    NEW_STRING_PROP(crypto_pwhash_PRIMITIVE);

    NEW_INT_PROP(crypto_pwhash_argon2i_ALG_ARGON2I13);
    NEW_NUMBER_PROP(crypto_pwhash_argon2i_SALTBYTES);
    NEW_NUMBER_PROP(crypto_pwhash_argon2i_STRBYTES);
    NEW_STRING_PROP(crypto_pwhash_argon2i_STRPREFIX);
    NEW_NUMBER_PROP(crypto_pwhash_argon2i_OPSLIMIT_INTERACTIVE);
    NEW_NUMBER_PROP(crypto_pwhash_argon2i_MEMLIMIT_INTERACTIVE);
    NEW_NUMBER_PROP(crypto_pwhash_argon2i_OPSLIMIT_MODERATE);
    NEW_NUMBER_PROP(crypto_pwhash_argon2i_MEMLIMIT_MODERATE);
    NEW_NUMBER_PROP(crypto_pwhash_argon2i_OPSLIMIT_SENSITIVE);
    NEW_NUMBER_PROP(crypto_pwhash_argon2i_MEMLIMIT_SENSITIVE);
}
