/**
 * Created by bmf on 11/2/13.
 */
var assert = require('assert');
var sodium = require('../build/Release/sodium');

describe("randombytes_buf", function () {
    it("sould return a buffer full of random data", function (done) {
        var b = Buffer.alloc(100);
        sodium.randombytes_buf(b);
        assert(!b.equals(Buffer.alloc(100)));
        done();
    });

    it("sould not change size of buffer", function (done) {
        var b = Buffer.alloc(100);
        sodium.randombytes_buf(b);
        assert(b.length == 100);
        done();
    });

    it("sould throw on argument being a string", function (done) {
        var v = "123";
        assert.throws(function() {
            sodium.randombytes_buf(v);
        });
        
        done();
    });

    it("sould throw on argument being a boolean", function (done) {
        var v = true;
        assert.throws(function() {
            sodium.randombytes_buf(v);
        });
        
        done();
    });

    it("sould throw on argument being an object", function (done) {
        var v = { a: 123 };
        assert.throws(function() {
            sodium.randombytes_buf(v);
        });
        
        done();
    });

    it("sould throw on argument being an array", function (done) {
        var v = [ 1, 2, 3];
        assert.throws(function() {
            sodium.randombytes_buf(v);
        });
        
        done();
    });
});

describe("randombytes_random", function () {
    it("sould return a random number", function (done) {
        var n = sodium.randombytes_random();
        assert(typeof n === "number");
        done();
    });
});

describe("randombytes_uniform", function () {
    it("sould return a random number smaller than 100", function (done) {
        var n = sodium.randombytes_uniform(100);
        assert(typeof n === "number");
        done();
    });

    it("sould throw on argument being a string", function (done) {
        var v = "123";
        assert.throws(function() {
            var n = sodium.randombytes_uniform(v);
        });
        
        done();
    });

    it("sould throw on argument being a boolean", function (done) {
        var v = true;
        assert.throws(function() {
            var n = sodium.randombytes_uniform(v);
        });
        
        done();
    });

    it("sould throw on argument being an object", function (done) {
        var v = { a: 123 };
        assert.throws(function() {
            var n = sodium.randombytes_uniform(v);
        });
        
        done();
    });

    it("sould throw on argument being an array", function (done) {
        var v = [ 1, 2, 3];
        assert.throws(function() {
            var n = sodium.randombytes_uniform(v);
        });
        
        done();
    });
});

describe("randombytes_buf_deterministic", function () {
    it("sould return a buffer full of random data", function (done) {
        var b = Buffer.alloc(100);
        var seed = Buffer.alloc(sodium.randombytes_SEEDBYTES);

        sodium.randombytes_buf_deterministic(b, seed);

        assert(!b.equals(Buffer.alloc(100)));
        done();
    });

    it("sould throw on argument being a string", function (done) {
        var v = "123";
        var seed = Buffer.alloc(sodium.randombytes_SEEDBYTES);
        assert.throws(function() {
            sodium.randombytes_buf_deterministic(v, seed);
        });
        
        done();
    });

    it("sould throw on argument being a number", function (done) {
        var v = 123;
        var seed = Buffer.alloc(sodium.randombytes_SEEDBYTES);
        assert.throws(function() {
            sodium.randombytes_buf_deterministic(v, seed);
        });
        
        done();
    });

    it("sould throw on argument being a boolean", function (done) {
        var v = true;
        var seed = Buffer.alloc(sodium.randombytes_SEEDBYTES);
        assert.throws(function() {
            sodium.randombytes_buf_deterministic(v, seed);
        });
        
        done();
    });

    it("sould throw on argument being an object", function (done) {
        var v = { a: 123 };
        var seed = Buffer.alloc(sodium.randombytes_SEEDBYTES);
        assert.throws(function() {
            sodium.randombytes_buf_deterministic(v, seed);
        });
        
        done();
    });

    it("sould throw on argument being an array", function (done) {
        var v = [ 1, 2, 3];
        var seed = Buffer.alloc(sodium.randombytes_SEEDBYTES);
        assert.throws(function() {
            sodium.randombytes_buf_deterministic(v, seed);
        });
        
        done();
    });

    it("sould throw on argument 2 being an invalid length seed", function (done) {
        var v = Buffer.alloc(100);
        var seed = Buffer.alloc(sodium.randombytes_SEEDBYTES + 100);
        assert.throws(function() {
            sodium.randombytes_buf_deterministic(v, seed);
        });
        
        done();
    });

    it("sould throw on argument 2 being a string", function (done) {
        var v = Buffer.alloc(100);
        var seed = "123";
        assert.throws(function() {
            sodium.randombytes_buf_deterministic(seed, v);
        });
        
        done();
    });

    it("sould throw on argument 2 being a bool", function (done) {
        var v = Buffer.alloc(100);
        var seed = true;
        assert.throws(function() {
            sodium.randombytes_buf_deterministic(seed, v);
        });
        
        done();
    });

    it("sould throw on argument 2 being a number", function (done) {
        var v = Buffer.alloc(100);
        var seed = 123;
        assert.throws(function() {
            sodium.randombytes_buf_deterministic(seed, v);
        });
        
        done();
    });

    it("sould throw on argument 2 being an object", function (done) {
        var v = Buffer.alloc(100);
        var seed = { a: "123" };
        assert.throws(function() {
            sodium.randombytes_buf_deterministic(seed, v);
        });
        
        done();
    });

    it("sould throw on argument 2 being an array", function (done) {
        var v = Buffer.alloc(100);
        var seed = [1, 2, 3];
        assert.throws(function() {
            sodium.randombytes_buf_deterministic(seed, v);
        });
        
        done();
    });

    it("sould generate a known sequence", function (done) {
        var b1 = Buffer.alloc(100);
        var b2 = Buffer.alloc(100);
        var b3 = Buffer.alloc(100);
        var b4 = Buffer.alloc(100);
        
        var c1 = Buffer.alloc(100);
        var c2 = Buffer.alloc(100);
        var c3 = Buffer.alloc(100);
        var c4 = Buffer.alloc(100);
        
        var seed1 = Buffer.alloc(sodium.randombytes_SEEDBYTES);
        var seed2 = Buffer.alloc(sodium.randombytes_SEEDBYTES);
        var seed3 = Buffer.alloc(sodium.randombytes_SEEDBYTES);
        var seed4 = Buffer.alloc(sodium.randombytes_SEEDBYTES);

        sodium.randombytes_buf_deterministic(b1, seed1);
        sodium.randombytes_buf_deterministic(b2, seed2);
        sodium.randombytes_buf_deterministic(b3, seed3);
        sodium.randombytes_buf_deterministic(b4, seed4);

        sodium.randombytes_buf_deterministic(c1, seed1);
        sodium.randombytes_buf_deterministic(c2, seed2);
        sodium.randombytes_buf_deterministic(c3, seed3);
        sodium.randombytes_buf_deterministic(c4, seed4);

        assert(b1.equals(c1));
        assert(b2.equals(c2));
        assert(b3.equals(c3));
        assert(b4.equals(c4));

        done();
    });

});