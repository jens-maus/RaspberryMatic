exports(secretKey, publicKey)
-----------------------------
Public-key authenticated encryption: Box




**Parameters**

**secretKey**:  *String|Buffer|Array*,  sender's private key.

**publicKey**:  *String|Buffer|Array*,  recipient's private key.

boxZeroBytes()
--------------
SecretBox padding of cipher text buffer

zeroBytes()
-----------
Passing of message. This implementation does message padding automatically

primitive()
-----------
String name of the default crypto primitive used in secretbox operations

key()
-----
Get the box-key secret key object


setEncoding(encoding)
---------------------
Set the default encoding to use in all string conversions


**Parameters**

**encoding**:  *String*,  encoding to use

getEncoding()
-------------
Get the current default encoding


encrypt(plainText, \[encoding\])
--------------------------------
Encrypt a message
The crypto_secretbox function is designed to meet the standard notions of
privacy and authenticity for a secret-key authenticated-encryption scheme
using nonces. For formal definitions see, e.g., Bellare and Namprempre,
"Authenticated encryption: relations among notions and analysis of the
generic composition paradigm," Lecture Notes in Computer Science
1976 (2000), 531–545, http://www-cse.ucsd.edu/~mihir/papers/oem.html.

Note that the length is not hidden. The basic API leaves it up to the
caller to generate a unique nonce for every message, in the high level
API a random nonce is generated automatically and you do no need to
worry about it.

If no options are given a new random nonce will be generated automatically
and both planText and cipherText must be buffers




**Parameters**

**plainText**:  *Buffer|String|Array*,  message to encrypt

**[encoding]**:  *String*,  encoding of message string

**Returns**

*Object*,  cipher box

decrypt(cipherText, nonce, \[encoding\])
----------------------------------------
The decrypt function verifies and decrypts a cipherText using the
receiver's secret key, the sender's public key, and a nonce.
The function returns the resulting plaintext m.



**Parameters**

**cipherText**:  *Buffer|String|Array*,  the encrypted message

**nonce**:  *Buffer|String|Array*,  the nonce used to encrypt

**[encoding]**:  *String*,  the encoding to used in cipherText, nonce, plainText

