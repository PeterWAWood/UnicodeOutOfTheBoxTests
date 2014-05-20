// Tests for JavaScript engines such as Nitro, V8, SpiderMonkey and Rhino
var unicodeString;
var title;
var passed = 0;
var failed = 0;

var testFailed = function testFailed() {
  failed += 1;
  print('Failed ' + title);
};

var test = function test(name, result) {
  if (result) {
    passed++;
  } else {
    failed++;
    print('Test ' + name + ' failed');
  }
};

test('Unicode 1', 'c\u0327' === '\u00E7');

test('Unicode 2', 'c\u0327' !== '\u00E7');

test('Unicode 3', 'noe\u0308l'.length === 4);

test('Unicode 4', 'noe\u0308l'.split('').reverse().join('') === 'le\u0308on');

test('Unicode 5', 'noe\u0308l'.slice(0,2) === 'noe\u0308');

test('Unicode 6', 'ba\uFB04e'.toUpperCase() === 'BAFFLE');

test('Unicode 7', 'cant\u00F9'.toUpperCase() === 'CANT\u00D9');

test('Unicode 8', 'cantu\u0300'.toUpperCase() === 'CANTU\u0300');


unicodeString = '\uD834\uDD1E - The Treble Clef';
unicodeString = unicodeString.replace('\uD834\uDD1E', '\uD834\uDD22');
test('Unicode 9', unicodeString.replace('Treble', 'Bass') === 
                                        '\uD834\uDD22 - The Bass Clef');

test('Unicode 10', '\uD834\uDD22 - The Bass Clef'.length === 17);

// As far as I can tell there is no way to swet the locale or language in JavaScript
test('Unicode 11', 'i'.toUpperCase === '\u0130');

test('Unicode 12', 'I'.toLowerCase === '\u0131');

test('Unicode 13', 'stra\u00DFe'.toUpperCase === 'STRASSE');

test('Unicode 14', '\u03C8\u3099'.length === 1);

test('Unicode 15', 'e\u0308\uD834\uDD1E\u03C8\u3099'.length === 3);

test('Unicode 16', 'wei\u00DF'.match(/weiss/i));

print('Tests run  ' + (passed + failed));
print('Passed     ' + passed);
print('Failed     ' + failed);
