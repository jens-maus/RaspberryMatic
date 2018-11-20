/**
 * Created by bmf on 11/2/13.
 */
 /* jslint node: true */
'use strict';

var util = require('util');
var binding = require('../../build/Release/sodium');
var KeyPair = require('./keypair');

var Box = function BoxKey(publicKey, secretKey, encoding) {
    var self = this;

    KeyPair.call(this);

    self.init({
        publicKeySize : binding.crypto_box_PUBLICKEYBYTES,
        secretKeySize : binding.crypto_box_SECRETKEYBYTES,
        publicKey : publicKey,
        secretKey : secretKey,
        type: 'BoxKey'
    });

    self.generate = function() {
        var keys = binding.crypto_box_keypair();
        self.secretKey.set(keys.secretKey);
        self.publicKey.set(keys.publicKey);
    };
    

    if( !publicKey || !secretKey ||
        !self.isValid({ 'publicKey': publicKey, 'secretKey': secretKey }) ) {

        // Generate the keys
        self.generate();
    }
};
util.inherits(Box, KeyPair);
module.exports = Box;