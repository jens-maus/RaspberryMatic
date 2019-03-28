/**
 * toBuffer Module
 * Convert value into a buffer
 *
 * @name node-sodium
 * @author bmf
 * @date 11/5/13
 * @version $
 */
/* jslint node: true */
'use strict';

var re = /^(?:utf8|ascii|binary|hex|utf16le|ucs2|base64)$/
/**
 * Convert value into a buffer
 *
 * @param {String|Buffer|Array} value  a buffer, and array of bytes or a string that you want to convert to a buffer
 * @param {String} [encoding]          encoding to use in conversion if value is a string. Defaults to 'hex'
 * @returns {*}
 */
function toBuffer(value, encoding) {

    if( typeof value === 'string') {

        encoding = encoding || 'hex';
        
        if( !re.test(encoding) ) {
            throw new Error('[toBuffer] bad encoding. Must be: utf8|ascii|binary|hex|utf16le|ucs2|base64');
        }
        
        try {
            return Buffer.from(value, encoding);
        }
        catch (e) {
            throw new Error('[toBuffer] string value could not be converted to a buffer :' + e.message);
        }

    }
    else if( typeof value === 'object' ) {
        if( Buffer.isBuffer(value) ) {
            return value;
        }
        else if( value instanceof Array ) {
            try {
                return Buffer.from(value);
            }
            catch (e) {
                throw new Error('[toBuffer] Array could not be converted to a buffer :' + e.message);
            }
        }
    }
    throw new Error('[toBuffer] unsupported type in value. Use Buffer, string or Array');
}

module.exports = toBuffer;
