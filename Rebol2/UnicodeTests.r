#!/usr/local/bin/run

Rebol [
	Title: "Unicode Tests"
	Date: 16-May-2014
	Author: "Christopher Ross-Gill"
	Reference: https://github.com/PeterWAWood/UnicodeOutOfTheBoxTests
]

failed: 0
passed: 0
test: func [name [string!] result [logic!]] [
  either result [
    passed: passed + 1
  ][
    failed: failed + 1
    print ["Test" name "failed"]
  ]
]

test "Unicode 01" equal? "c^(CC)^(A7)" "^(C3)^(A7"  
   
test "Unicode 02" not-equal? "c^(CC)^(A7)" "^(C3)^(A7)"  
   
test "Unicode 03" equal? 4 length? "noe^(CC)^(88)l"
   
test "Unicode 04" equal? "le^(CC)^(88)on" reverse "noe^(CC)^(88)l"
   
test "Unicode 05" equal? "noe^(CC)^(88)" copy/part "noe^(CC)^(88)l" 3
  
test "Unicode 06" equal? "BAFFLE" uppercase "ba^(EF)^(AC)^(84)e"
   
test "Unicode 07" equal? "CANT^(C3)^(99)" uppercase "cant^(C3)^(B9)"
   
test "Unicode 08" equal? "CANTU^(CC)^(80)" uppercase "cantu^(CC)^(80)"

unicode-string: "^(F0)^(9D)^(84)^(9E) - The Treble Clef"
replace unicode-string "^(F0)^(9D)^(84)^(9E)" "^(F0)^(9D)^(84)^(A2)"
replace unicode-string "Treble" "Bass"
test "Unicode 09" equal? "^(F0)^(9D)^(84)^(A2) - The Bass Clef" unicode-string
   
test "Unicode 10" equal? 17 length? "^(F0)^(9D)^(84)^(A2) - The Bass Clef"
   
test "Unicode 11" equal? "^(C4)^(B0)" uppercase "i"
   
test "Unicode 12" equal? "^(C4)^(B1)" lowercase "I"
   
test "Unicode 13" equal? "STRASSE" uppercase "stra^(C3)^(9F)e"
   
test "Unicode 14" equal? 1 length? "^(E3)^(83)^(88)^(E3)^(82)^(99)"
   
test "Unicode 15" equal? 3,"e^(CC)^(88)^(F0)^(9D)^(84)^(9E)^(E3)^(83)^(88)^(E3)^(82)^(99)"
   
test "Unicode 16" equal? "wei^(C3)^(9F)e" "weiss"
   
test "Unicode 17" equal? "e^(CC)^(83)^(CD)(BD)^(CC)^(AA)"
                         "e^(CC)^(AA)^(CC)^(83)^(CD)^(8D)"
   
test "Unicode 18" equal? "XII"  "^(E2)^(85)^(AB)"
   
test "Unicode 19" not-equal? "XII" "^(E2)^(85)^(AB)"
    
test "Unicode 20" equal? "^(E1)^(B8)^(94)" "^(E1)^(B8)^(94)"
   
test "Unicode 21" equal? "E^(CC)^(84)^(CC)^(80)" "^(E1)^(B8)^(94)"
   
test "Unicode 22" equal? "^(E1)^(B8)^(94)" "^(C4)^(92)^(CC)^(80)"
   
test "Unicode 23" equal? "E^(CC)^(84)^(CC)^(80)" "^(C4)^(92)^(CC)^(80)"
   
test "Unicode 24" equal? "^(C3)^(88)^(CC)^(84)" "^(C3)^(88)^(CC)^(84)"
   
test "Unicode 25" not-equal? "e^(CC)^(AA)^(CC)^(83)^(CD)^(BD)"
                             "e^(CD)^(BD)^(CC)^(AA)^(CC)^(83)"

print ["Tests:        " passed + failed]
print ["Passed:       " passed]
print ["Failed:       " failed] 
