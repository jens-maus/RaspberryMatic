# Summary

This file contains some testfunctions which can be used in a clean browser page (about:blank).
To use this first copy the proofAndSetValue Function into the console. Followed up by the testfunctions below.

Afterwards just copy all tests or just those relevant for you.
Feel free to extend the testcases.

## Testfunctions

function testProofAndSetValue(testname, eingabe, min, max, dstValueFactor, erwartungswert) {
    var srcID = `srcID`;
    var destID = `destID`;

    document.body.innerHTML = `<input id="${srcID}" type="text"/><input id="${destID}" type="text"/>`;
    var srcElem = $(srcID);
    srcElem.value = eingabe;

    ProofAndSetValue(srcID, destID, min, max, dstValueFactor, undefined);

    var srcVal = $(srcID).value;
    var destVal = $(destID).value;
    if(srcVal !== erwartungswert || destVal !== erwartungswert) {
        console.log(`Fehler bei Test "${testname}": Erwartungswert: ${erwartungswert}\tNeuer SRC Wert: ${srcVal}\tNeuer Dest Wert: ${destVal}`);
    }
}
$F = function (selector) {
    return $(selector).value;
}
conInfo = function(e) { console.log(e)}
roundValue05 = function(val) {
  var intVal = Math.floor(val);
  if (val - intVal > 0.5) {
    return Math.ceil(val);
  }

  if (val - intVal == 0) {
    return val;
  }

  return intVal + 0.5;
};
$ = function(selector) {
    return document.getElementById(selector)
}

## Tests

function runTest() {
    console.clear();
    testProofAndSetValue("1. Integer below Minimum", "5", "10", "20", 1, "10");
    testProofAndSetValue("2. Integer above Maximum", "21", "10", "20", 1, "20");
    testProofAndSetValue("3. Float below Minimum", "1.5", "10.0", "20.0", 1, "10.0");
    testProofAndSetValue("4. Float above Maximum", "21.5", "10.0", "20.0", 1, "20.0");
    testProofAndSetValue("5. Float Digits are kept", "11.0", "10.0", "20.0", 1, "11.0");
    testProofAndSetValue("6. Float digits are truncated", "11.05", "10.0", "20.0", 1, "11.1");
    testProofAndSetValue("7. Float digits are added", "11.5", "10.00", "20.00", 1, "11.50");
    testProofAndSetValue("8. Integer gets rounded", "11.51", "10", "20", 1, "12");
    testProofAndSetValue("9. Invalid number results in minimum", "a", "10", "20", 1, "10");
    testProofAndSetValue("10. not dotted value gets interpreted correctly", "11,5", "10.0", "20.0", 1, "11.5");
    testProofAndSetValue("11. Longitute allowed negative value", "-1,9", "-180.0", "180.0", 1, "-1.9");
    testProofAndSetValue("12. Longitute positive value", "2.0", "-180.0", "180.0", 1, "2.0");
}
runTest();
