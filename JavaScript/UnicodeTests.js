// Tests for JavaScript engines such as Nitro, V8, SpiderMonkey and Rhino
var unicodeString;
var title;
var passed = 0;
var failed = 0;

var testFailed = function testFailed() {
  failed += 1;
  print('Failed ' + title);
};

title = 'Test 1';
unicodeString = 'c\u0327';
if (unicodeString === '\u00E7') {
  passed += 1;
} else {
  testFailed();  
}

title = 'Test 2';
unicodeString = 'c\u0327';
if (unicodeString !== '\u00E7') {
  passed += 1;
} else {
  testFailed();  
}

title = 'Test 3';
unicodeString = 'noe\u0308l';
if (unicodeString.length === 4) {
  passed += 1;
} else {
  testFailed();
}

title = 'Test 4';
unicodeString = 'noe\u0308l';
if (unicodeString.split('').reverse().join('') === 'le\u0308on') {
  passed += 1;
} else {
  testFailed();
}

title = 'Test 5';
unicodeString = 'noe\u0308l';
if (unicodeString.slice(0,2) === 'noe\u0308') {
  passed += 1;
} else {
  testFailed();
}

title = 'Test 6';
unicodeString = 'ba\uFB04e';
if (unicodeString.toUpperCase() === 'BAFFLE') {
  passed += 1;
} else {
  testFailed();
}

title = 'Test 7';
unicodeString = 'cant\u00F9';
if (unicodeString.toUpperCase() === 'CANT\u00D9') {
  passed += 1;
} else {
  testFailed();
}

title = 'Test 8';
unicodeString = 'cantu\u0300';
if (unicodeString.toUpperCase() === 'CANTU\u0300') {
  passed += 1;
} else {
  testFailed();
}

title = 'Test 9';
unicodeString = '\uD834\uDD1E - The Treble Clef';
unicodeString = unicodeString.replace('\uD834\uDD1E', '\uD834\uDD22');
if (unicodeString.replace('Treble', 'Bass') === '\uD834\uDD22 - The Bass Clef') {
  passed += 1;
} else {
  testFailed();
}

title = 'Test 10';
unicodeString = '\uD834\uDD22 - The Bass Clef';
if (unicodeString.length === 17) {
  passed += 1;
} else {
  testFailed();
}

title = 'Test 11';
// As far as I can tell there is no way to swet the locale or language in JavaScript
unicodeString = 'i';
if (unicodeString.toUpperCase === '\u0130') {
  passed += 1;
} else {
  testFailed();
}

title = 'Test 12';
unicodeString = 'I';
if (unicodeString.toLowerCase === '\u0131') {
  passed += 1;
} else {
  testFailed();
}

title = 'Test 13';
unicodeString = 'stra\u00DFe';
if (unicodeString.toUpperCase === 'STRASSE') {
  paseed += 1;
} else {
  testFailed();
}

title = 'Test 14';
unicodeString = '\u03C8\u3099';
if (unicodeString.length === 1) {
  pasesd += 1;
} else {
  testFailed();
}

title = 'Test 15';
unicodeString = 'e\u0308\uD834\uDD1E\u03C8\u3099';
if (unicodeString.length === 3) {
  passed += 1;
} else {
  testFailed();
}

title = 'Test 16';
if ('wei\u00DF'.match(/weiss/i)) {
 passed += 1;
} else {
  testFailed();
}


print('Tests run  ' + (passed + failed));
print('Passed     ' + passed);
print('Failed     ' + failed);
