init(options, options.keyModule, options.keyPair, options.publicKey, options.secretKey)
---------------------------------------------------------------------------------------
Init object


**Parameters**

**options**:  *Object*,  


**options.keyModule**:  *String*,  name of module in keys directory

**options.keyPair**:  *Boolean*,  if true we're using the key pair class

**options.publicKey**:  *String|Buffer|Array*,  public key to init the key class

**options.secretKey**:  *String|Buffer|Array*,  secret key to init the key class

key()
-----
Get the box-key secret keypair object


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
The encrypt function encrypts and authenticates a message using the
sender's secret key, the receiver's public key, and a nonce n.

If no options are given a new random nonce will be generated automatically
and both planText and cipherText must be buffers

options.encoding is optional and specifies the encoding of the plainText
nonce, and cipherText if they are passed as strings. If plainText and
nonce are buffers, options.encoding will only affect the resulting
cipherText.
The basic API leaves it up to the
caller to generate a unique nonce for every message, in the high level
API a random nonce is generated automatically and you do no need to
worry about it.




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

