crypto_pwhash_argon2i(out, passwd, salt, oppLimit, memLimit, alg)
-----------------------------------------------------------------

Store a password hash in `output` using [Argon2i](https://github.com/P-H-C/phc-winner-argon2).

**Parameters**

**out**: *Buffer*, Output buffer to store the hash in. Should be able to store `sodium.crypto_pwhash_argon2i_STRBYTES`.

**passwd**: *Buffer*, Password to hash.

**salt**: *Buffer*, Salt for hash. Must be exactly `sodium.crypto_pwhash_argon2i_SALTBYTES`.

**oppLimit**: *Number*, Maximum number of computations to perform. Higher values will require more CPU cycles.

**memLimit**: *Number*, Maximum amount of RAM to consume, in bytes.

**alg**: *Number*, Algorithm to use. Currently only `sodium.crypto_pwhash_argon2i_ALG_ARGON2I13` is supported.

**Returns**

*boolean*, `true` if successful, `false` if not.


crypto_pwhash_argon2i_str(passwd, oppLimit, memLimit)
-----------------------------------------------------

Returns a buffer of size `sodium.crypto_pwhash_argon2i_STRBYTES` containing an ASCII-encoded string suitable for storage. It includes:

 - the hash
 - the salt, which has been automatically generated
 - the algorithm identifier and version
 - the `oppLimit` and `memLimit` that were used

**Parameters**

**passwd**: *Buffer*, Password to hash.

**oppLimit**: *Number*, Maximum number of computations to perform.

**memlimit**: *Number*, Maximum amount of RAM to consume, in bytes.

**Returns**

*Buffer*|*Boolean*, Hash buffer or `false` if hash unsuccessful.


crypto_pwhash_argon2i_str_verify(pwhash, passwd)
------------------------------------------------

Hashes `passwd` using the same parameters and salt as `pwhash` and compares the result.

**Parameters**

**pwhash**: *Buffer*, Hash generated with `crypto_pwhash_argon2i_str`.

**pass**: *Buffer*, Password to verify.

**Returns**

*Boolean*, `true` if `passwd` is verified, `false` if not.


crypto_pwhash(out, passwd, salt, oppLimit, memLimit, alg)
---------------------------------------------------------

Store a password hash in `out` using the specified algorithm.

**Parameters**

**out**: *Buffer*, Output buffer to store the hash in. Should be able to store `sodium.crypto_pwhash_STRBYTES`.

**passwd**: *Buffer*, Password to hash.

**salt**: *Buffer*, Salt for hash. Must be exactly `sodium.crypto_pwhash_SALTBYTES`.

**oppLimit**: *Number*, Maximum number of computations to perform.

**memLimit**: *Number*, Maximum amount of RAM to consume, in bytes.

**alg**: *Number*, Algorithm to use. Currently `sodium.crypto_pwhash_argon2i_ALG_ARGON2I13` and `sodium.crypto_pwhash_ALG_DEFAULT` are supported.

**Returns**

*Boolean*|*null*, `true` if hash successful, `null` if not.


crypto_pwhash_str(passwd, oppLimit, memLimit)
-----------------------------------------

Returns a buffer of size `sodium.crypto_pwhash_STRBYTES` containing an ASCII-encoded string suitable for storage. It includes:

 - the hash
 - the salt, which has been automatically generated
 - the algorithm identifier and version
 - the `oppLimit` and `memLimit` that were used

**Parameters**

**passwd**: *Buffer*, Password to hash.

**oppLimit**: *Number*, Maximum number of computations to perform.

**memlimit**: *Number*, Maximum amount of RAM to consume, in bytes.

**Returns**

*Buffer*|*Boolean*, Hash buffer or `false` if unsuccessful.


crypto_pwhash_str_verify(pwhash, passwd)
----------------------------------------

Hashes `passwd` using the same parameters and salt as `pwhash` and compares the result.

**Parameters**

**pwhash**: *Buffer*, Hash generated with `crypto_pwhash_str`.

**pass**: *Buffer*, Password to verify.

**Returns**

*Boolean*, `true` if `passwd` verified, `false` if not.


crypto_pwhash_scryptsalsa208sha256(out, passwd, salt, oppLimit, memLimit)
---------------------------------------------------------------------------------

Stores a hash of `passwd` in `out` using Scrypt with Salsa20/8 core and SHA-256.

**Parameters**

**out**: *Number*, Output buffer.

**passwd**: *Buffer*, Password to hash.

**salt**: *Buffer*, Salt for hash. Must be `crypto_pwhash_scryptsalsa208sha256_SALTBYTES` in length.

**oppLimit**: *Number*, Maximum number of computations to perform.

**memLimit**: *Number*, Maximum amount of RAM to consume, in bytes.

**Returns**

*Boolean*, `true` if successful, `false` if not.


crypto_pwhash_scryptsalsa208sha256_ll(passwd, salt, N, r, p, out)
-----------------------------------------------------------------

Stores a hash of `passwd` in `out` using the low-level Scrypt API.

**Parameters**

**passwd**: *Buffer*, Password to hash.

**salt**: *Buffer*, Salt for hash. Must be `crypto_pwhash_scryptsalsa208sha256_SALTBYTES` in length.

**N**: *Number*, CPU/memory cost. Higher values increase both CPU and memory cost. Must be a power of 2 greater than 1.

**r**: *Number*, Block size for hash, in bytes. Higher values increase relative memory cost.

**p**: *Number*, Parallelization factor. Higher values increase relative CPU cost.

**out**: *Buffer*, Output buffer to store the hash in. Should be able to store `crypto_pwhash_scryptsalsa208sha256_STRBYTES`.

**Returns**

*Boolean*, `true` if successful, `false` if not.


crypto_pwhash_scryptsalsa208sha256_str(passwd, oppLimit, memLimit)
------------------------------------------------------------------

Returns a hash of `passwd` using Scrypt.

**Parameters**

**passwd**: *Buffer*, Password to hash.

**oppLimit**: *Number*, Maximum number of computations to perform.

**memLimit**: *Number*, Maximum amount of RAM to consume, in bytes.

**Returns**

*Buffer*|*null*, Hash buffer or null if unsuccessful.


crypto_pwhash_scryptsalsa208sha256_str_verify(pwhash, passwd)
-------------------------------------------------------------

Hashes `passwd` using Scrypt with the parameters stored in `pwhash`, and compares the result with `pwhash`. 

**Parameters**

**passwd**: *Buffer*, Password to hash.

**oppLimit**: *Number*, Maximum number of computations to perform.

**memLimit**: *Number*, Maximum amount of RAM to consume, in bytes.

**Returns**

*Boolean*, `true` if `passwd` verified, `false` if not.


crypto_pwhash_ALG_DEFAULT
-------------------------

Default hashing algorithm to use. Currently `crypto_pwhash_argon2i_ALG_ARGON2I13`.


crypto_pwhash_SALTBYTES
-----------------------

Size of salt buffer in bytes. Algorithm-specific values: `crypto_pwhash_scryptsalsa208sha256_SALTBYTES`, `crypto_pwhash_argon2i_SALTBYTES`.


crypto_pwhash_STRBYTES
----------------------

Size of returned hash buffer, in bytes. Algorithm-specific values: `crypto_pwhash_argon2i_STRBYTES`,
`crypto_pwhash_scryptsalsa208sha256_STRBYTES`.


crypto_pwhash_STRPREFIX
-----------------------

Algorithm-specific values: `crypto_pwhash_argon2i_STRPREFIX`, `crypto_pwhash_scryptsalsa208sha256_STRPREFIX`.


crypto_pwhash_OPSLIMIT_INTERACTIVE
----------------------------------
ons
A suitable default for fast hashes used with interactive logins. Algorithm-specific values: `crypto_pwhash_argon2i_OPSLIMIT_INTERACTIVE`, `crypto_pwhash_scryptsalsa208sha256_OPSLIMIT_INTERACTIVE`.


crypto_pwhash_MEMLIMIT_INTERACTIVE
----------------------------------

A suitable default for fast hashes used with interactive logins (32 MB RAM consumed). Algorithm-specific values: `crypto_pwhash_argon2i_MEMLIMIT_INTERACTIVE`, `crypto_pwhash_scryptsalsa208sha256_MEMLIMIT_INTERACTIVE`.


crypto_pwhash_OPSLIMIT_MODERATE
-------------------------------

A suitable default for normal use (moderate speed). Algorithm-specific values: `crypto_pwhash_argon2i_OPSLIMIT_MODERATE`.


crypto_pwhash_MEMLIMIT_MODERATE
-------------------------------

A suitable default for normal use (moderate speed). Algorithm-specific values: `crypto_pwhash_argon2i_MEMLIMIT_MODERATE`.


crypto_pwhash_OPSLIMIT_SENSITIVE
--------------------------------

A suitable default for slow hashes with highly-sensitive data. Algorithm-specific values: `crypto_pwhash_argon2i_OPSLIMIT_SENSITIVE`, `crypto_pwhash_scryptsalsa208sha256_OPSLIMIT_SENSITIVE`.


crypto_pwhash_MEMLIMIT_SENSITIVE
--------------------------------

A suitable default for slow hashes with highly-sensitive data. Algorithm-specific values: `crypto_pwhash_argon2i_MEMLIMIT_SENSITIVE`, `crypto_pwhash_scryptsalsa208sha256_MEMLIMIT_SENSITIVE`.


crypto_pwhash_PRIMITIVE
-----------------------

Currently set to "argon2i".

