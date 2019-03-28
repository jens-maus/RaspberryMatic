
# Ported Functions

List of all functions ported by node-sodium

## Version
  * version
  * version_minor
  * version_major

## Utilities
  * memzero
  * memcmp
  * crypto_verify_16
  * crypto_verify_32

## Random 
  * randombytes_buf
  * randombytes_close
  * randombytes_stir
  * randombytes_random
  * randombytes_uniform

## Hash
  * crypto_hash
  * crypto_hash_sha512
  * crypto_hash_sha256

## Auth
  * crypto_auth
  * crypto_auth_verify

## One Time Auth
  * crypto_onetimeauth
  * crypto_onetimeauth_verify

## Stream
  * crypto_stream
  * crypto_stream_xor

## Secret Box
  * crypto_secretbox
  * crypto_secretbox_open

## Sign
  * crypto_sign
  * crypto_sign_keypair
  * crypto_sign_open
  * crypto_sign_detached
  * crypto_sign_verify_detached
  * crypto_sign_ed25519_pk_to_curve25519
  * crypto_sign_ed25519_sk_to_curve25519

## Box
  * crypto_box
  * crypto_box_easy
  * crypto_box_keypair
  * crypto_box_open
  * crypto_box_open_easy
  * crypto_box_beforenm
  * crypto_box_afternm
  * crypto_box_open_afternm

## ShortHash
  * crypto_shorthash

## Scalar Mult
  * crypto_scalarmult
  * crypto_scalarmult_base
