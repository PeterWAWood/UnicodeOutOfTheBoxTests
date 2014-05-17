#!/usr/local/bin/run

Rebol [
	Title: "Unicode Tests"
	Date: 16-May-2014
	Author: "Christopher Ross-Gill"
	Reference: https://github.com/PeterWAWood/UnicodeOutOfTheBoxTests
]

test-1: func [
	{
		Equality of precomposed and decomposed characters
		Compare U+00E7 with "c" followed by U+0327
		The expected result is true.
		U+00E7 is UTF-8 C3 A7
		U+0327 is UTF-8 CC A7
	}
][
	assert-equal
		"ç" = "ç"
		true
]

test-2: func [
	{
		Non-equality of precomposed and decomposed characters  
		Compare U+00E7 with "c" followed by U+0327
		The expected result is false.

		(This test is to see if the language provides flexibility)
	}
][
	assert-equal
		"ç" == "ç"
		false
]

test-3: func [
	{
		Length of text containing decomposed characters that have precomposed alternative
		Length of "noeU+0308l"
		The expected result is 4.
		U+0308 is UTF-8 CC 88
	}
][
	assert-equal
		length? "noël"
		4
]

test-4: func [
	{
		Reversing a string containing decomposed characters
		Reverse "noeU+0308l"
		The expected result is "leU+0308on"
	}
][
	assert-equal
		reverse "noël"
		"lëon"
]

test-5: func [
	{
		Correct substring of a string containing decomposed characters
		Extract the first three characters of "noeU+0308l"
		The expected result is "noeU+0308"
	}
][
	assert-equal
		copy/part "noël" 3
		"noë"
]

test-6: func [
	{
		Correct uppercase of U+FB04
		Upper case of "baU+FB04e"
		The expected result is "BAFFLE"
		The length of the expected result is 6
		U+FB04 is UTF-8 EF AC 84
	}
][
	assert-equal
		uppercase "baﬄe"
		"BAFFLE"
]

test-7: func [
	{
		Correct uppercase of precomposed chars
		Upper case of "cantU+00F9"
		The expected result is "CANTU+00D9"
		U+00D9 is UTF-8 C3 99
		U+00F9 is UTF-8 C3 B9
	}
][
	assert-equal
		uppercase "cantù"
		"CANTÙ"
]

test-8: func [
	{
		Correct uppercase of decomposed chars
		Upper case of "cantuU+0300"
		The expected result is "CANTUU+0300"
		U+0300 is UTF-8 CC 80
	}
][
	assert-equal
		uppercase "cantù"
		"CANTÙ"
]

test-9: func [
	{
		Processing above BMP
		Change treble clef symbol of "U+1D11E - The Treble Clef" to bass clef symbol(U+1D122)
		Change "Treble" to "Bass"
		The expected result is "U+1D122 - The Bass Clef"
		U+1D11E is UTF-8 F0 9D 84 9E
		U+1D122 is UTF-8 F0 9D 84 A2
	}
][
	assert-equal
		replace replace "턞 - The Treble Clef" "턞" "턢" "Treble" "Bass"
		"턢 - The Bass Clef"
]

test-10: func [
	{
		Processing above BMP
		Length of "U+1D122 - The Bass Clef"
		The expected result is 17
	}
][
	assert-equal
		length? "턢 - The Bass Clef"
		17
]

test-11: func [
	{
		Special Case - Turkish - Upper case "i"
		Set locale/Language to indicate Turkish 
		Upper case "i"
		The expected result is U+0130
		U+0130 is UTF-8 C4 B0

		(Requires the ability to indicate that Turkish language rules should be used.)
	}
][
	if in system/locale 'language [system/locale/language: "Turkish"]
	assert-equal
		uppercase "i"
		"İ"

	if in system/locale 'language [system/locale/language: none]
]

test-12: func [
	{
		Special Case - Turkish - Lower case "I"
		Set locale/Language to indicate Turkish 
		Lower case "I"
		The expected result is U+0131
		U+0130 is UTF-8 C4 B1

		(Requires the ability to indicate that Turkish language rules should be used.)
	}
][
	if in system/locale 'language [system/locale/language: "Turkish"]
	assert-equal
		lowercase "I"
		"ı"

	if in system/locale 'language [system/locale/language: none]
]

test-13: func [
	{
		Upper Case sharp s (U+00DF)
		Upper case "straU+00DFe"
		The expected result is "STRASSE"
		U+00DF is UTF-8 C3 9F
	}
][
	assert-equal
		uppercase "straße"
		"STRASSE"
]

test-14: func [
	{
		Length of text with decomposed characters with no precomposed alternative
		Length of "U+30C8U+3099"
		The expected result is 1
		U+30C8 is UTF-8 E3 83 88
		U+3099 is UTF-8 E3 82 99
	}
][
	assert-equal
		length? "ド"
		1
]

test-15: func [
	{
		Length of text with decomposed characters and characters above BMP
		Length of "eU+0308lU+1D11EU+30C8U+3099"
		The expected result is 3
	}
][
	assert-equal
		length? "ël턞ド"
		3
]