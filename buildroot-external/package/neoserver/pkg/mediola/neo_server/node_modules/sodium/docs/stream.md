exports(\[secretKey\])
----------------------
**Parameters**

**[secretKey]**:  *String|Buffer|Array*,  A valid stream secret key

primitive()
-----------
String name of the default crypto primitive used in stream operations

key()
-----
Get the auth-key secret key object


setEncoding(encoding)
---------------------
Set the default encoding to use in all string conversions


**Parameters**

**encoding**:  *String*,  encoding to use

getEncoding()
-------------
Get the current default encoding


encrypt(message, \[encoding\])
----------------------------
Encrypt the message



**Parameters**

**message**:  *string|Buffer|Array*,  message to authenticate

**[encoding**:  *String*,  ]  If v is a string you can specify the encoding

decrypt(cipherText, nonce, \[encoding\])
----------------------------------------
The decrypt function verifies and decrypts a cipherText using the
secret key and a nonce.
The function returns the resulting plaintext m.



**Parameters**

**cipherText**:  *Buffer|String|Array*,  the encrypted message

**nonce**:  *Buffer|String|Array*,  the nonce used to encrypt

**[encoding]**:  *String*,  the encoding to return the plainText

