# Key Management

To help with the key management tasks it is possible to use node-sodium's key manager, which can store one or more keys for your application

This is a full Javascript implementation meant to be used server side, where assurance that direct memory access is not available to remote users.
You should not use this functionality if you plan on deploying node-sodium in an environment where users can read nodeJS's memory space, as it can compromize keying information.

## Key File

Keys can be written and read from the key file. This is a JSON formated file where all the keys are encrypted using a, what else, Sodium strem cypher.

Format:

    {
        nonce: 123123123123,
      
        keys: {  
            "key_alias_1" : {
                type: key_type,
                key: {
                    
                }
            },
            "key_alias_2" : {
                type: key_type,
                key: {
                    ...
                },
          
            ...
            }
        }    
    }

## saveKey(keyObject, keyAlias)

## getKey(keyAlias)

## saveKeys(fileName)

## loadKeys(fileName, secretPassword)