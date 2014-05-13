UnicodeOutOfTheBoxTests
=======================

A short set of tests to give an indication of how well a language supports Unicode "Out of the Box".


Musing Mortoray's [blog article] (http://mortoray.com/2013/11/27/the-string-type-is-broken/) and the comments provided a helpful starting point for these tests.

In this context, "out of the box" means capabilities either built-in to the language or its standard libraries that are supplied with the language. (I.E. No additional downloads).

###The Tests 
```
1.  Equality of precomposed and decomposed characters
    Compare U+00E7 with "c" followed by U+0327
    The expected result is true.

2.  Non-equality of precomposed and decomposed characters  
    Compare U+00E7 with "c" followed by U+0327
    The expected result is false.

    (This test is to see if the language provides flexibility)

3.  Correct length of text containing decomposed characters
    Length of "noeU+0308l"
    The expected result is 4.

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

7.  Correct uppercase of precomposed chars
    Upper case of "cantU+00F9"
    The expected result is "CANTU+00D9"

8.  Correct uppercase of decomposed chars
    Upper case of "cantuU+0300"
    The expected result is "CANTUU+0300"

9.  Processing above BMP
    Change treble clef symbol of "U+1D11E - The Treble Clef" to bass clef symbol(U+1D122)
    Change "Treble" to "Bass"
    The expected result is "U+1D122 - The Bass Clef"

10. Special Case - Turkish - Upper case "i"
    Set locale/Language to indicate Turkish 
    Upper case "i"
    The expected result is U+0130

    (Requires the ability to indicate that Turkish language rules should be used.)

11. Special Case - Turkish - Lower case "I"
    Set locale/Language to indicate Turkish 
    Lower case "I"
    The expected result is U+0131

    (Requires the ability to indicate that Turkish language rules should be used.)
   
12. Upper Case sharp s (U+00DF)
    Upper case "straU+00DFe"
    The expected result is "STRASSE"
```

###The Results

```
Language                                Score
LiveCode 7                          9 out of 12
JavaScript                          5 out of 12
```

###The Code and Detailed Results
Both the code and the detailed results are stored in a separate folder for each language under the main directory. The results are simply the console output (or equivalent) saved in a text file.

###Improving the Tests
I have no doubt that the tests could be improved. If you have any suggestions to make, please do so by raising an issue in this repository.

###Improving the Code
I also have little doubt that the code could be improved. However the purpose of this repository is to check the Unicode features of the language, so as long as the code correctly reflects that it is sufficient. If the code does not properly reflect the out-of-the-box capability of the language, please submit a pull request with the corrected code.

###Adding Further Languages
Contributions of the tests written in languages not currently covered would be most welcome. Please submit a pull request with the code and results
