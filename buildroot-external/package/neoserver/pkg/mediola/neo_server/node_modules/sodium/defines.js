var fs = require('fs');
var os = require('os');

console.log("Extracting DEFINES from Libsodium make file...");
console.log("Detected system architecture " + os.arch());

var libsodium_dir = "./deps/libsodium";

fs.readFile(libsodium_dir + "/Makefile", 'utf8', function (err, make) {
  console.log("Libsodium Makefile : " + libsodium_dir + "/Makefile");
  if (err) {
    console.log("Please run autogen.sh and configure in " + libsodium_dir + " directory first");
    return console.log(err);
  }
  
  // Extract DEFS
  var defs = make.match(/DEFS = ([^\n]+)/);
  if (!defs) {
    return console.log("No DEFS found in libsodium Makefile");
  }

  var re = /-D(.*?)(?:(?=\s?-D)|$)/g;
  var m;
  var d = "";   
  while ((m = re.exec(defs[1])) != null) {
    if (m.index === re.lastIndex) {
      re.lastIndex++;
    }
    // View your result using the m-variable.
    d += "\t\t\t\t'" + m[1] + "',\n";
  }

  d = d.replace(/\\/g, '');
  fs.readFile("deps/libsodium.gyp.in", 'utf8', function (err, template) {
    console.log("Libsodium GYP template file " + "deps/libsodium.gyp.in");

    if (err) {
      return console.log(err);
    }

    var result = template.replace(/{DEFINES}/g, d);
    result = result.replace(/{ARCH}/g, "'" + os.arch() + "'");

    fs.writeFile("deps/libsodium.gyp", result, 'utf8', function (err) {
       if (err) return console.log(err);
        console.log("Writing output to GYP file deps/libsodium.gyp");
       return true;
    });
    return true;
  });
  return true;
});