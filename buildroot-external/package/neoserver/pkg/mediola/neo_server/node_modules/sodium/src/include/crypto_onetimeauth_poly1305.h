/**
 * Node Native Module for Lib Sodium
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */
#ifndef __CRYPTO_ONETIMEAUTH_POLY1305_H__
#define __CRYPTO_ONETIMEAUTH_POLY1305_H__

NAN_METHOD(bind_crypto_onetimeauth_poly1305);
NAN_METHOD(bind_crypto_onetimeauth_poly1305_verify);
NAN_METHOD(bind_crypto_onetimeauth_poly1305_init);
NAN_METHOD(bind_crypto_onetimeauth_poly1305_update);
NAN_METHOD(bind_crypto_onetimeauth_poly1305_final);

#endif