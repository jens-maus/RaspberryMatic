[![build status](https://secure.travis-ci.org/lmaccherone/node-localstorage.png)](http://travis-ci.org/lmaccherone/node-localstorage)
# node-localstorage #

Copyright (c) 2012, Lawrence S. Maccherone, Jr.

_A drop-in substitute for the browser native localStorage API that runs on node.js._

### Fully implements the localStorage specfication including: ###

* All methods in the [localStorage spec](http://www.w3.org/TR/webstorage/#storage) 
  interface including:
  * length
  * setItem(key, value)
  * getItem(key)
  * removeItem(key)
  * key(n)
  * clear()  
* Serializes to disk in the location specified during instantiation
* Supports the setting of a quota (default 5MB)
* Events. This doesn't exactly follow the spec which states that events are NOT supposed to be emitted to the 
  browser window that took the action that triggered the event in the first place. They are only to be emitted to listeners in other browser windows. Early browser implementations actually did it this way and we don't really have the equivalent of a browser window in node.js, so we choose to implement them in the current process.
* Associative array `localStorage['myKey'] = 'myValue'` and dot property `localStorage.myKey = 'myValue'`
  syntax. If you are in an ES6 supported environment. Limitations:
  * You won't be able to use keys that collide with my "private" (starts with "_" like "_init") properties and
    methods.

## Credits ##

Author: [Larry Maccherone](http://maccherone.com)

## Usage ##

### CoffeeScript ###

```coffee
unless localStorage?
  {LocalStorage} = require('../')  # require('node-localstorage') for you
  localStorage = new LocalStorage('./scratch')

localStorage.setItem('myFirstKey', 'myFirstValue')
console.log(localStorage.getItem('myFirstKey'))
# myFirstValue

localStorage._deleteLocation()  # cleans up ./scratch created during doctest
```

### ReactJs ###

Open or create `src/setupTests.js` and add these two lines:

``` JavaScript
// /src/setupTests.js
import { LocalStorage } from "node-localstorage";

global.localStorage = new LocalStorage('./scratch');
```

### JavaScript ###

```JavaScript    
if (typeof localStorage === "undefined" || localStorage === null) {
  var LocalStorage = require('node-localstorage').LocalStorage;
  localStorage = new LocalStorage('./scratch');
}

localStorage.setItem('myFirstKey', 'myFirstValue');
console.log(localStorage.getItem('myFirstKey'));
```

### Polyfill on Node.js ###

Polyfil your node.js environment with this as the global localStorage when launching your own code

```sh
node -r node-localstorage/register my-code.js
```

## Installation ##

`npm install node-localstorage`

## Changelog ##

* 2.1.5 - 2019-12-02 - Fixed empty string key(n) return (@appy-one, thanks for reporting)
* 2.1.2 thru 2.1.4 - 2019-11-17 - Upgrading and testing npm publish scripts
* 2.1.1 - 2019-11-17 - npm publish cleanup
* 2.1.0 - 2019-11-17 - Added back dot-property and associative-array syntax using ES6 Proxy
* 2.0.0 - 2019-11-17 - Updated all the depdendencies, added ability to register as polyfill (thanks @dy)
* 1.3.1 - 2018-03-19 - Resolves issue #32 (thanks, plamens)
* 1.3.0 - 2016-04-09 - **Possibly backward breaking if you were using experimental syntax** Reverted experimental
  associative array and dot-property syntax. The API for Proxy changed with node.js v6.x which broke it. Then when
  I switched to the new syntax, it broke the EventEmitter functionality. Will restore once I know how to fix that.
* 1.2.0 - 2016-04-09 - Atomic writes (thanks, mvayngrib)
* 1.1.2 - 2016-01-08 - Resolves issue #17 (thanks, evilaliv3)
* 1.1.1 - 2016-01-04 - Smarter associative array and dot-property syntax support
* 1.1.0 - 2016-01-03 - **Backward breaking** if you used any of the non-standard methods. They are now all preceded with
  an underscore. Big upgrade for this version is experimental support for associative array and dot-property syntax.
* 1.0.0 - 2016-01-03 - Fixed bug with empty string key (thanks, tinybike)
* 0.6.0 - 2015-09-11 - Removed references to deprecated fs.existsSync() (thanks, josephbosire)
* 0.5.2 - 2015-08-01 - Fixed defect where keys were not being updated correctly by removeItem() (thanks, ed69140)
* 0.5.1 - 2015-06-01 - Added support for events
* 0.5.0 - 2015-02-02 - Added JSONStorage class which allows you set and get native JSON
* 0.4.1 - 2015-02-02 - More robust publishing/tagging (like Lumenize)
* 0.4.0 - 2015-02-02 - Uses more efficient fs.statSync to set initial size (thanks, sudheer594)
* 0.3.6 - 2014-12-24 - Allows usage without `new`
* 0.3.5 - 2014-12-23 - Fixed toString() for QuotaExceededError
* 0.3.4 - 2013-07-07 - Moved CoffeeScript to devDependencies
* 0.3.3 - 2013-04-05 - Added support for '/' in keys by escaping before creating file names
* 0.3.2 - 2013-01-19 - Renamed QuotaExceededError to QUOTA_EXCEEDED_ERR to match most browsers
* 0.3.1 - 2013-01-19 - Fixed bug where it threw plain old Error instead of new QuotaExceededError
* 0.3.0 - 2013-01-19 - Added QuotaExceededError support
* 0.2.0 - 2013-01-03 - Added quota support
* 0.1.2 - 2012-11-02 - Finally got Travis CI working
* 0.1.1 - 2012-10-29 - Update to support Travis CI
* 0.1.0 - 2012-10-29 - Original version
