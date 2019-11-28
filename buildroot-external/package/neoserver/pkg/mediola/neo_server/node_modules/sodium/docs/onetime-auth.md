exports(\[secretKey\])
----------------------
One Time Message Authentication


The secretKey *MUST* remain secret or an attacker could forge valid
authenticator tokens

If key is not given a new random key is generated



**Parameters**

**[secretKey]**:  *String|Buffer|Array*,  A valid auth secret key

bytes()
-------
Size of the authentication token

primitive()
-----------
String name of the default crypto primitive used in onetimeauth operations

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


generate(message, \[encoding)
-----------------------------
Generate authentication token for message, based on the secret key



**Parameters**

**message**:  *string|Buffer|Array*,  message to authenticate

**[encoding**:  *String*,  ]  If v is a string you can specify the encoding

validate(token, message, \[encoding\])
--------------------------------------
Checks if the token authenticates the message



**Parameters**

**token**:  *String|Buffer|Array*,  message token

**message**:  *String|Buffer|Array*,  message to authenticate

**[encoding]**:  *String*,  If v is a string you can specify the encoding

