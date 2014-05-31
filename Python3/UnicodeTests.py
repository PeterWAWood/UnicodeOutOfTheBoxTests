__license__ = '''
Copyright (C) 2014 Andreas Bolka

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
'''

import unicodedata
import unittest


def nfc(unistr):
    return unicodedata.normalize('NFC', unistr)


def nfd(unistr):
    return unicodedata.normalize('NFD', unistr)


def nfkd(unistr):
    return unicodedata.normalize('NFKD', unistr)


class UnicodeTests(unittest.TestCase):
    def test_01(self):
        self.assertEqual(nfd('\u00E7'), nfd('c\u0327'))

    def test_02(self):
        self.assertNotEqual('\u00E7', 'c\u0327')

    def test_03(self):
        # That's probably cheating a bit and should use grapheme clustering.
        # However, proper grapheme clustering is covered by tests 14 & 15.
        self.assertEqual(len(nfc('noe\u0308l')), 4)

    def test_04(self):
        # See remark on test_03.
        self.assertEqual(nfd(''.join(reversed(nfc('noe\u0308l')))),
                         'le\u0308on')

    def test_05(self):
        # See remark on test_03.
        self.assertEqual(nfd(nfc('noe\u0308l')[:3]), 'noe\u0308')

    def test_06(self):
        self.assertEqual('baﬄe'.upper(), 'BAFFLE')
        self.assertEqual(len('baﬄe'.upper()), 6)

    def test_07(self):
        self.assertEqual('cant\u00F9'.upper(), 'CANT\u00D9')

    def test_08(self):
        self.assertEqual('cantu\u0300'.upper(), 'CANTU\u0300')

    def test_09(self):
        self.assertEqual(
            '𝄞 - The Treble Clef'.replace('𝄞', '𝄢').replace('Treble', 'Bass'),
            '𝄢 - The Bass Clef')

    def test_10(self):
        self.assertEqual(len('𝄢 - The Bass Clef'), 17)

    def test_11(self):
        # Python currently lacks locale-sensisitive Unicode case conversion in
        # the stdlib. Quoting the Python 3.4 docs for the locale module: "There
        # is no way to perform case conversions and character classifications
        # according to the locale."
        self.assertEqual('i'.upper(), 'İ')

    def test_12(self):
        # See test_11.
        self.assertEqual('I'.lower(), 'ı')

    def test_13(self):
        self.assertEqual('straße'.upper(), 'STRASSE')

    def test_14(self):
        # Needs grapheme clustering. See eg http://bugs.python.org/issue12733.
        self.assertEqual(len('\u30C8\u3099'), 1)

    def test_15(self):
        # See remark on test_14.
        self.assertEqual(len('e\u3081\U0001D11E\u30C8\u3099'), 3)

    def test_16(self):
        self.assertEqual('weiß'.casefold(), 'weiss')

    def test_17(self):
        self.assertEqual(nfd('e\u0303\u033D\u032A'), 'e\u032A\u0303\u033D')

    def test_18(self):
        self.assertEqual('XII', nfkd('\u216B'))

    def test_19(self):
        self.assertNotEqual('XII', '\u216B')


if __name__ == '__main__':
    unittest.main()
