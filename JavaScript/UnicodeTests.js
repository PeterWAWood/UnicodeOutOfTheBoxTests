// Tests for JavaScript engines such as Nitro, V8, SpiderMonkey and Rhino
var unicodeString;
var title;
var passed = 0;
var failed = 0;

var failedTest = function failedTest() {
  failed += 1;
  print('Failed ' + title);
};

title = 'Test 1';
unicodeString = 'c\u0327';
if (unicodeString === '\u00E7') {
  passed += 1;
} else {
  failedTest();  
}

title = 'Test 2';
unicodeString = 'c\u0327';
if (unicodeString !== '\u00E7') {
  passed += 1;
} else {
  failedTest();  
}

title = 'Test 3';
unicodeString = 'noe\u0308l';
if (unicodeString.length === 4) {
  passed += 1;
} else {
  failedTest();
}

title = 'Test 4';
unicodeString = 'noe\u0308l';
if (unicodeString.split('').reverse().join('') === 'le\u0308on') {
  passed += 1;
} else {
  failedTest();
}

title = 'Test 5';
unicodeString = 'noe\u0308l';
if (unicodeString.slice(0,2) === 'noe\u0308') {
  passed += 1;
} else {
  failedTest();
}

title = 'Test 6';
unicodeString = 'ba\uFB04e';
if (unicodeString.toUpperCase() === 'BAFFLE') {
  passed += 1;
} else {
  failedTest();
}

title = 'Test 7';
unicodeString = 'cant\u00F9';
if (unicodeString.toUpperCase() === 'CANT\u00D9') {
  passed += 1;
} else {
  failedTest();
}

title = 'Test 8';
unicodeString = 'cantu\u0300';
if (unicodeString.toUpperCase() === 'CANTU\u0300') {
  passed += 1;
} else {
  failedTest();
}

title = 'Test 9';
unicodeString = '\uD834\uDD1E - The Treble Clef';
unicodeString = unicodeString.replace('\uD834\uDD1E', '\uD834\uDD22');
if (unicodeString.replace('Treble', 'Bass') === '\uD834\uDD22 - The Bass Clef') {
  passed += 1;
} else {
  failedTest();
}

title = 'Test 10';
unicodeString = '\uD834\uDD22 - The Bass Clef';
if (unicodeString.length === 17) {
  passed += 1;
} else {
  failedTest();
}

title = 'Test 11';
unicodeString = 'i';
if (unicodeString.toUpperCase === '\u0130') {
  passed += 1;
} else {
  failedTest();
}

title = 'Test 12';
unicodeString = 'I';
if (unicodeString.toLowerCase === '\u0131') {
  passed += 1;
} else {
  failedTest();
}

title = 'Test 13';
unicodeString = 'stra\u00DFe';
if (unicodeString.toUpperCase === 'STRASSE') {
  paseed += 1;
} else {
  failedTest();
}




print('Tests run  ' + (passed + failed));
print('Passed     ' + passed);
print('Failed     ' + failed);
