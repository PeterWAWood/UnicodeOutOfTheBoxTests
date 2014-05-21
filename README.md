UnicodeOutOfTheBoxTests
=======================

A short set of tests to give an indication of how well a language supports Unicode "Out of the Box". These tests only address basic string features and not text processing features such as end of word and paragraph support. 


Musing Mortoray's [blog article] (http://mortoray.com/2013/11/27/the-string-type-is-broken/) and the comments provided a helpful starting point for these tests.

In this context, "out of the box" means capabilities either built-in to the language or its standard libraries that are supplied with the language. (I.E. No additional downloads).

###The Tests 
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
    
16. Performing case insensitive comparison
    Compare "weiss" with "weiß"
    The expected result is true
    ß is U+00DF, UTF-8 C3 9F
```

###The Results

```
Language                          Score         Comment
Cocoa - Objective-C           16 out of 16      Needs to be run under OSX 10.8+
Go                             4 out of 16      
Java                          15 out of 16
LiveCode 7                    12 out of 16
JavaScript                     5 out of 16
Perl                          14 out of 16      16 out of 16 with CPAN Unicode::Casing
Python 3                      12 out of 16
Rebol 3                        3 out of 16
Ruby                           5 out of 16      16 out of 16 with UnicodeUtils Gem 
```

###The Code and Detailed Results
Both the code and the detailed results are stored in a separate folder for each language under the main directory. The results are simply the console output (or equivalent) saved in a text file.

###Improving the Tests
I have no doubt that the tests could be improved. If you have any suggestions to make, please do so by raising an issue in this repository.

###Improving the Code
I also have little doubt that the code could be improved. It is quite possible that the code does not properly reflect the out-of-the-box capability of the language. Please submit a pull request if you can improve it.

Please bear in mind that the purpose of this repository is to check the Unicode features of the language, so as long as the code correctly reflects them it is sufficient.

###Adding Further Languages
Contributions of the tests written in languages not currently covered would be most welcome. Please submit a pull request with the code and results
