exports(\[secretKey\])
----------------------
Message Authentication

Security model

The crypto_auth function, viewed as a function of the message for a uniform
random key, is designed to meet the standard notion of unforgeability. This
means that an attacker cannot find authenticators for any messages not
authenticated by the sender, even if the attacker has adaptively influenced
the messages authenticated by the sender. For a formal definition see,
e.g., Section 2.4 of Bellare, Kilian, and Rogaway, "The security of the
cipher block chaining message authentication code," Journal of Computer and
System Sciences 61 (2000), 362–399;
http://www-cse.ucsd.edu/~mihir/papers/cbc.html.

NaCl does not make any promises regarding "strong" unforgeability; perhaps
one valid authenticator can be converted into another valid authenticator
for the same message.
NaCl also does not make any promises regarding "truncated unforgeability."

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
String name of the default crypto primitive used in auth operations

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

