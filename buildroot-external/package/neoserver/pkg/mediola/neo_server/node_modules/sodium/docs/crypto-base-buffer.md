init(expectedSize, \[value\], \[encoding\])
-------------------------------------------
Initialize object
If a key is not given generate a new random key.

Valid keys, once converted to a node buffer, must have expectedSize in length.
If a key is represented by a string the string length depends on the encoding
so do not rely on string lengths to calculate key sizes.



**Parameters**

**expectedSize**:  *number*,  expected size of the buffer in bytes

**[value]**:  *String|Buffer|Array*,  value to initialize the buffer with

**[encoding]**:  *Srting*,  encoding to use in conversion if value is a string. Defaults to 'hex'

setEncoding(encoding)
---------------------
Set the default encoding to use in all string conversions


**Parameters**

**encoding**:  *String*,  encoding to use

getEncoding()
-------------
Get the current default encoding


getType()
---------
Return the type of data stored in the buffer.
Example: "BoxKeyPublicKey" for a Box object's public key


setValidEncodings(encList)
--------------------------
Set the valid string encodings

A lot of cryptographic functions rely on random buffer data that cannot
be accurately converted to and from some encoding schemes. This method
allows you to restrict the string encoding to settings you know will work



**Parameters**

**encList**:  *Array*,  array of strings with supported encodings

error(errorMessage)
-------------------
Generate a new Error appropriate to use with throw


**Parameters**

**errorMessage**,  


toBuffer(value, \[encoding\])
-----------------------------
Convert value into a buffer



**Parameters**

**value**:  *String|Buffer|Array*,  a buffer, and array of bytes or a string that you want to convert to a buffer

**[encoding]**:  *String*,  encoding to use in conversion if value is a string. Defaults to 'hex'

size()
------
Get the length of the buffer


**Returns**

*number*,  length in bytes of the buffer

isValid(value, \[encoding\])
----------------------------
Check if value could be used by CryptoBaseBuffer as a buffer



**Parameters**

**value**:  *String|Buffer|Array*,  to test

**[encoding]**:  *String*,  encoding to use in conversion if value is a string. Defaults to 'hex'

**Returns**

*boolean*,  true      if value could be used as a CryptoBaseBuffer

wipe()
------
Wipe buffer securely


generate()
----------
Fill buffer with random bytes
This method can be redefined in each sub-class to implement
the specific needs of that class


get()
-----
Getter for the baseBuffer


**Returns**

*undefined| Buffer*,  secret key

set(value, \[encoding\])
------------------------
Set the secret key to a known value


**Parameters**

**value**:  *String|Buffer|Array*,  the secret value to set the buffer to

**[encoding]**:  *String*,  If v is a string you can specify the encoding.

toString(optional)
------------------
Convert the secret key to a string object


**Parameters**

**optional**:  *ncoding {String*,  sting encoding. defaults to 'hex'

serialize(\[encoding\])
-----------------------
Serialize a CryptoBaseBuffer



**Parameters**

**[encoding]**:  *String*,  encoding used to convert the buffer to a string

**Returns**

*string*,  parsable JSON string

deserialize(obj)
----------------
Deserialize object. Take a parsable JSON string and create a valid buffer object



**Parameters**

**obj**:  *Object*,  parsable JSON String

