Note the [Generic Hashing](https://download.libsodium.org/doc/hashing/generic_hashing.html) section of the libsodium documentation, on which this document heavily depends.

Implemented using BLAKE2b. This function set should not be used to hash passwords. Use `crypto_pwhash` instead.


crypto_generichash(out_size, in, key)
-------------------------------------

Compute a fixed length fingerprint for a message of arbitrary length. Use cases include file integrity checks (fulfilling a similar role to MD5 and SHA-1, but with better security) and creating unique identifiers to index data of arbitrary length.

**Parameters**

**out_size**: *Number*, Output length in bytes. Should be between `crypto_generichash_BYTES_MIN` and `crypto_generichash_BYTES_MAX` (inclusive). The minimum recommended size is `crypto_generichash_BYTES`.

**in**: *Buffer*, Message to hash.

**key**: *Buffer*, Should be between `crypto_generichash_KEYBYTES_MIN` and `crypto_generichash_KEYBYTES_MAX` (inclusive). Note the recommended size: `crypto_generichash_KEYBYTES`. Key can also be `null`, in which case the output will always have the same fingerprint. If a key _is_ specified, different keys hashing the same message should produce different fingerprints.

**Returns**

*Buffer*, Containing the resulting hash.


crypto_generichash_init(key, out_size)
--------------------------------------

Initialize a state in order to eventually produce an output of length `out_size`.

Together with `crypto_generichash_update` and `crypto_generichash_final`, forms the generichash streaming API. Useful for very large files or data streams.

**Parameters**

**key**: *Buffer*, See restrictions for generichash keys, above. Can be null.

**out_size**: *Number*, Eventual output length, in bytes.

**Returns**

*Buffer*, Containing state. Passed as initial parameter to `crypto_generichash_update` and `crypto_generichash_final`.


crypto_generichash_update(state, message)
-----------------------------------------

Process a chunk of the eventual completed message.

**Parameters**

**state**: *Buffer*, The result of a call to `crypto_generichash_init` or a previous call to `crypto_generichash_update`.

**message**: *Buffer*, Chunk of message to add.

**Returns**

*Buffer*, Containing state.


crypto_generichash_final(state, out_size)
-----------------------------------------

Obtain the output hash as a result of the streaming API state.

**Parameters**

**state**: *Buffer*, The result of a call to `crypto_generichash_update`.

**out_size**: *Number*, Output length, in bytes.

**Returns**

*Buffer*, Containing the resulting hash.


crypto_generichash_BYTES_MIN
----------------------------

Minimum permitted length of output hash, in bytes. Algorithm-specific variant: `crypto_generichash_blake2b_BYTES_MIN`.


crypto_generichash_BYTES_MAX
----------------------------

Maximum permitted length of output hash, in bytes. Algorithm-specific variant: `crypto_generichash_blake2b_BYTES_MAX`.


crypto_generichash_BYTES
------------------------

Recommended length of output hash to effectively ensure that two messages will not share the same fingerprint. Algorithm-specific variant: `crypto_generichash_blake2b_BYTES`.


crypto_generichash_KEYBYTES_MIN
-------------------------------

Minimum permitted length of key, in bytes. Algorithm-speficic variant: `crypto_generichash_blake2b_KEYBYTES_MIN`.


crypto_generichash_KEYBYTES_MAX
-------------------------------

Maximum permitted length of key, in bytes. Algorithm-specific variant: `crypto_generichash_blake2b_KEYBYTES_MAX`.


crypto_generichash_KEYBYTES
---------------------------

Recommended length of key, in bytes. Note that key can also be `null`, which leads to the message always having the same fingerprint. Algorithm-specific variant: `crypto_generichash_blake2b_KEYBYTES`.


Note
----

Node Sodium also exposes `crypto_generichash_blake2b`, `crypto_generichash_blake2b_init`, `crypto_generichash_blake2b_update`, and `crypto_generichash_blake2b_final`. In the interests of brevity these are not separately documented, but their usage and parameters are identical (with the exception of constant naming: see above list).

