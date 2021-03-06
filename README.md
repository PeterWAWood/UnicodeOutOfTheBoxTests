UnicodeOutOfTheBoxTests
=======================

## *** Warning ***
Whilst the tests are still relevant, the code is somewhat outdated. Ruby Unicode support is much improved from the version that was used for these tests. There are new languages that probably shold be included such as Rust and Swift.

## Out of the Box Tests
A short set of tests to give an indication of how well a language supports Unicode "Out of the Box". These tests only address basic string features and not text processing features such as end of word and paragraph support.

Musing Mortoray's [blog article] (http://mortoray.com/2013/11/27/the-string-type-is-broken/) and the comments provided a helpful starting point for these tests.

In this context, "out of the box" means capabilities either built-in to the language or its standard libraries that are supplied with the language. (I.E. No additional downloads).

### The Tests
```
1.  Equality of precomposed and decomposed characters
    Compare U+00E7 with "c" followed by U+0327
    The expected result is true.
    U+00E7 is UTF-8 C3 A7
    U+0327 is UTF-8 CC A7

2.  Non-equality of precomposed and decomposed characters
    Compare U+00E7 with "c" followed by U+0327
    The expected result is false.

    (This test is to see if the language provides flexibility)

3.  Length of text containing decomposed characters that have precomposed alternative
    Length of "noeU+0308l"
    The expected result is 4.
    U+0308 is UTF-8 CC 88

4.  Reversing a string containing decomposed characters
    Reverse "noeU+0308l"
    The expected result is "leU+0308on"

5.  Correct substring of a string containing decomposed characters
    Extract the first three characters of "noeU+0308l"
    The expected result is "noeU+0308"

6.  Correct uppercase of U+FB04
    Upper case of "baU+FB04e"
    The expected result is "BAFFLE"
    The length of the expected result is 6
    U+FB04 is UTF-8 EF AC 84

7.  Correct uppercase of precomposed chars
    Upper case of "cantU+00F9"
    The expected result is "CANTU+00D9"
    U+00D9 is UTF-8 C3 99
    U+00F9 is UTF-8 C3 B9

8.  Correct uppercase of decomposed chars
    Upper case of "cantuU+0300"
    The expected result is "CANTUU+0300"
    U+0300 is UTF-8 CC 80

9.  Processing above BMP
    Change treble clef symbol of "U+1D11E - The Treble Clef" to bass clef symbol(U+1D122)
    Change "Treble" to "Bass"
    The expected result is "U+1D122 - The Bass Clef"
    U+1D11E is UTF-8 F0 9D 84 9E
    U+1D122 is UTF-8 F0 9D 84 A2

10. Processing above BMP
    Length of "U+1D122 - The Bass Clef"
    The expected result is 17

11. Special Case - Turkish - Upper case "i"
    Set locale/Language to indicate Turkish
    Upper case "i"
    The expected result is U+0130
    U+0130 is UTF-8 C4 B0

    (Requires the ability to indicate that Turkish language rules should be used.)

12. Special Case - Turkish - Lower case "I"
    Set locale/Language to indicate Turkish
    Lower case "I"
    The expected result is U+0131
    U+0130 is UTF-8 C4 B1

    (Requires the ability to indicate that Turkish language rules should be used.)

13. Upper Case sharp s (U+00DF)
    Upper case "straU+00DFe"
    The expected result is "STRASSE"
    U+00DF is UTF-8 C3 9F

14. Length of text with decomposed characters with no precomposed alternative
    Length of "U+30C8U+3099"
    The expected result is 1
    U+30C8 is UTF-8 E3 83 88
    U+3099 is UTF-8 E3 82 99

15. Length of text with decomposed characters and characters above BMP
    Length of "eU+0308U+1D11EU+30C8U+3099"
    The expected result is 3

16. Perform case-insensitive (case folding) comparison
    Compare "weiss" with "weiß"
    The expected result is true
    ß is U+00DF, UTF-8 C3 9F
    
17. Equality of decomposed characters with different order of code points
    Compare "eU+0303U+033DU+032A" with "eU+032AU+0303U+033D"
    The expected result is true
    U+0303 is UTF-8 CC 83
    U+032A is UTF-8 CC AA
    U+033D is UTF-8 CD BD
    
18. Compatibility equivalence of three code point decomposed character with precomposed alternative
    Compare "XII" with "U+216B"
    The expected result is true
    U+216B is UTF-8 E2 85 AB
    
19. Canonical equivalence of three code point decomposed character with precomposed alternative
    Compare "XII" with "U+216B"
    The expected result is false
    U+216B is UTF-8 E2 85 AB

20. Normalisation of a precomposed character with a three code point decomposed form using NFC
    Normalise U+1E14
    The expected result is U+1E14
    U+1E14 is UTF-8 E1 88 94 

21. Normalisation of a precomposed character with a three code point decomposed form using NFD
    Normalise U+1E14
    The expected result is "EU+0304U+0300"
    U+1E14 is UTF-8 E1 88 94
    U+0304 is UTF-8 CC 84
    U+0300 is UTF-8 CC 80
    
22. Normalise precomposed + decomposed character to precomposed character with NFC
    Normalise "U+0112U+0300"
    The expected result is "U+1E14"
    U+0112 is UTF-8 C4 92
    
23. Normalise precomposed + decomposed character to three decomposed characters with NFD
    Normalise "U+0112U+0300"
    The expected result is "EU+0304U+0300"
   
24. Normalise precomposed + decomposed character to be unchanged with NFC
    Normalise "U+C8U+0304"
    The expected result is "U+C8U+0304"
   
25. Inequality of decomposed characters with different order of combining characters of the same class
    Compare "eU+0303U+033DU+032A" with "eU+033DU+032AU+0303"
    The expected result is false
    U+0303 is UTF-8 CC 83
    U+032A is UTF-8 CC AA
    U+033D is UTF-8 CD BD
```   
   
###  The Results

```
Language                          Score         Comment
Cocoa - Objective-C           25 out of 25      Needs to be run under OSX 10.8+
C#                            23 out of 25      Failing non-locale special casings
Factor                        25 out of 25
Go                             8 out of 25
Java                          25 out of 25
JavaScript                     9 out of 25
LiveCode 7                    21 out of 25
Perl                          23 out of 25      25 out of 25 with CPAN Unicode::Casing
PHP                           23 out of 25      
Python 3                      21 out of 25
Racket                        23 out of 25      Needs `tr_TR.UTF-8` locale data available
Rebol 2                        7 out of 25      Uses UTF-8
Rebol 3                        7 out of 25
Red 0.42                       8 out of 25
Ruby                          13 out of 25      25 out of 25 with UnicodeUtils Gem
```

### The Code and Detailed Results
Both the code and the detailed results are stored in a separate folder for each language under the main directory. The results are simply the console output (or equivalent) saved in a text file.

### Improving the Tests
I have no doubt that the tests could be improved. If you have any suggestions to make, please do so by raising an issue in this repository.

### Improving the Code
I also have little doubt that the code could be improved. It is quite possible that the code does not properly reflect the out-of-the-box capability of the language. Please submit a pull request if you can improve it.

Please bear in mind that the purpose of this repository is to check the Unicode features of the language, so as long as the code correctly reflects them it is sufficient.

### Adding Further Languages
Contributions of the tests written in languages not currently covered would be most welcome. Please submit a pull request with the code and results
