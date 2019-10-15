
// this should reveal wrong iteration on arrays
Array.prototype.someNewMethod = function() {};

var test  = require('unit.js');

describe('winreg', function(){
  
  it('running on Windows', function () {
    
    test.string(process.platform)
    . is('win32');
    
  });
  
  // Registry class
  var Registry = require(__dirname+'/../../lib/registry.js');
  
  it('Registry is a class', function () {
    
    test.function(Registry)
    . hasName('Registry');
    
  });
  
  // create a uniqe registry key in HKCU to test in
  var regKey = new Registry({
    hive: Registry.HKCU,
    key:  '\\Software\\AAA_' + new Date().toISOString()
  });
  
  it('regKey is instance of Registry', function(){
    
    test.object(regKey)
    . isInstanceOf(Registry);
    
  });
  
  // a key that has subkeys in it
  var softwareKey = new Registry({
    hive: Registry.HKCU,
    key:  '\\Software'
  });
  
  it('softwareKey is instance of Registry', function(){
    
    test.object(softwareKey)
    . isInstanceOf(Registry);
    
  });
  
  describe('Registry', function (){
    
    describe('keyExists()', function(){
      
      it('regKey has keyExists method', function () {
        
        test.object(regKey)
        . hasProperty('keyExists');
        
        test.function(regKey.keyExists)
        . hasName('keyExists');
        
      });
      
      it('regKey does not already exist', function(done) {
        
        regKey.keyExists(function (err, exists) {
          
          if (err) throw err;
          
          test.bool(exists)
          . isNotTrue();
          
          done();
          
        });
        
      });
      
    }); // end - describe keyExists()
    
    describe('create()', function(){
      
      it('regKey has create method', function () {
        
        test.object(regKey)
        . hasProperty('create');
        
        test.function(regKey.create)
        . hasName('create');
        
      });
      
      it('regKey can be created', function(done) {
        
        regKey.create(function (err) {
          
          if (err) throw err;
          
          done();
          
        });
        
      });
      
      it('regKey exists after being created', function(done) {
        
        regKey.keyExists(function (err, exists) {
          
          if (err) throw err;
          
          test.bool(exists)
          . isTrue();
          
          done();
          
        });
        
      });
      
    }); // end - describe create()
    
    describe('set()', function (){
      
      it('regKey has set method', function () {
        
        test.object(regKey)
        . hasProperty('set');
        
        test.function(regKey.set)
        . hasName('set');
        
      });
      
      it('can set a string value', function (done) {
        
        regKey.set('SomeString', Registry.REG_SZ, 'SomeValue', function (err) {
          
          if (err) throw err;
          
          done();
          
        });
        
      });
      
    }); // end - describe set
    
    describe('valueExists()', function (){
      
      it('regKey has valueExists method', function () {
        
        test.object(regKey)
        . hasProperty('valueExists');
        
        test.function(regKey.valueExists)
        . hasName('valueExists');
        
      });
      
      it('can check for existing string value', function (done) {
        
        regKey.valueExists('SomeString', function (err, exists) {
          
          if (err) throw err;
          
          test.bool(exists)
          . isTrue();
          
          done();
          
        });
        
      });
      
    }); // end - describe valueExists
    
    describe('get()', function (){
      
      it('regKey has get method', function () {
        
        test.object(regKey)
        . hasProperty('get');
        
        test.function(regKey.get)
        . hasName('get');
        
      });
      
      it('can get a string value', function (done) {
        
        regKey.get('SomeString', function (err, item) {
          
          if (err) throw err;
          
          test.object(item)
          . hasProperty('value', 'SomeValue');
          
          done();
          
        });
        
      });
      
    }); // end - describe get
    
    describe('values()', function (){
      
      it('regKey has values method', function () {
        
        test.object(regKey)
        . hasProperty('values');
        
        test.function(regKey.values)
        . hasName('values');
        
      });
      
      it('returns array of RegistryItem objects', function (done) {
        
        regKey.values(function (err, items) {
          
          if (err) throw err;
          
          for (var i=0; i<items.length; i++) {
            
            var item = items[i];
            
            test.object(item)
            . hasProperty('value');
            
          }
          done();
          
        });
        
      });
      
    }); // end - describe values
    
    describe('remove()', function (){
      
      it('regKey has remove method', function () {
        
        test.object(regKey)
        . hasProperty('remove');
        
        test.function(regKey.remove)
        . hasName('remove');
        
      });
      
      it('can remove a string value', function (done) {
        
        regKey.remove('SomeString', function (err) {
          
          if (err) throw err;
          
          done();
          
        });
        
      });
      
    }); // end - describe remove
    
    describe('keys()', function (){
      
      it('regKey has keys method', function () {
        
        test.object(regKey)
        . hasProperty('keys');
        
        test.function(regKey.keys)
        . hasName('keys');
        
      });
      
      it('returns array of Registry objects', function (done) {
        
        softwareKey.keys(function (err, keys) {
          
          if (err) throw err;
          
          test.array(keys);
          
          for (var i=0; i<keys.length; i++) {
            
            var key = keys[i];
            
            test.object(key)
            . isInstanceOf(Registry);
            
          }
          
          done();
          
        });
        
      });
      
    }); // end - describe keys()
    
    describe('clear()', function (){
      
      it('regKey has clear method', function () {
        
        test.object(regKey)
        . hasProperty('clear');
        
        test.function(regKey.clear)
        . hasName('clear');
        
      });
      
    }); // end - describe clear
    
    describe('destroy()', function(){
      
      it('regKey has destroy method', function () {
        
        test.object(regKey)
        . hasProperty('destroy');
        
        test.function(regKey.destroy)
        . hasName('destroy');
        
      });
      
      it('regKey can be destroyed', function(done) {
        
        regKey.destroy(function (err) {
          
          if (err) throw err;
          
          done();
          
        });
        
      });
      
      it('regKey is missing after being destroyed', function(done) {
        
        regKey.keyExists(function (err, exists) {
          
          if (err) throw err;
          
          test.bool(exists)
          . isFalse();
          
          done();
          
        });
        
      });
      
    }); // end - describe destroy()
  
  }); // end - describe Registry
  
}); // end - describe winreg
