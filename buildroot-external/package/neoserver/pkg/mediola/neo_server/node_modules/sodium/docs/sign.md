Sign(secretKey, publicKey)
--------------------------
Public-key authenticated message signatures: Sign




**Parameters**

**secretKey**:  *String|Buffer|Array*,  sender's private key.

**publicKey**:  *String|Buffer|Array*,  recipient's public key.

bytes()
-------
Size of the generated message signature

primitive()
-----------
String name of the default crypto primitive used in sign operations

key()
-----
Get the keypair object


size()
------
**Returns**

*Number*,  The size of the message signature

setEncoding(encoding)
---------------------
Set the default encoding to use in all string conversions


**Parameters**

**encoding**:  *String*,  encoding to use

getEncoding()
-------------
Get the current default encoding


sign(message, \[encoding\])
---------------------------
Digitally sign message




**Parameters**

**message**:  *Buffer|String|Array*,  message to sign

**[encoding]**:  *String*,  encoding of message string

**Returns**

*Object*,  cipher box

verify(cipherText)
------------------
Verify digital signature



**Parameters**

**cipherText**:  *Buffer|String|Array*,  the signed message

signDetached(message, \[encoding\])
---------------------------
Digitally sign message




**Parameters**

**message**:  *Buffer|String|Array*,  message to sign

**[encoding]**:  *String*,  encoding of message string

**Returns**

*Object*,  cipher box

verifyDetached(signature, message)
------------------
Verify digital signature



**Parameters**
** signature  the signature
** message *Buffer|String|Array*,   message to verify
