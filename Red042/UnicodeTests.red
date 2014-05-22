Red [
  Title:   "Red Unicode Out Of The Box Tests"
	Author:  "Peter W A Wood"
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/dockimbel/Red/blob/master/BSL-License.txt
	}	
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

test "Unicode 1" equal? "c^(0327)" "^(00E7)"

test "Unicode 2" not-equal? "c^(0327)" "^(00E7)"

test "Unicode 3" equal? 4 length? "noe^(0308)l"

test "Unicode 4" equal? "le^(0308)on" reverse "noe^(0308)l"

test "Unicode 5" equal? "noe^(0308)" copy/part "noe^(0308)l" 3

;; uppercase not implemented in Red 0.42, use case insensitive compare instead
;;test "Unicode 6" strict-equal? "BAFFLE" uppercase "ba^(FB04)e"
test "Unicode 6" equal? "BAFFLE" "ba^(FB04)e"

;; uppercase not implemented in Red 0.42, use case insensitive compare instead
;;test "Unicode 7" strict-equal? "CANT^(00F9)" uppercase "cant^(00D9)"
test "Unicode 7" equal? "CANT^(00F9)" "cant^(00D9)"

;; uppercase not implemented in Red 0.42, use case insensitive compare instead
;;test "Unicode 8" strict-equal? "CANTU^(0300)" uppercase "cantu^(0300)"
test "Unicode 8" equal? "CANTU^(0300)" "cantu^(0300)"

unicode-string: "^(01D11E) - The Treble Clef"
replace unicode-string "^(01D11E)" "^(01D122)"
replace unicode-string "Treble" "Bass"
test "Unicode 9" equal? "^(01D122) - The Bass Clef" unicode-string

test "Unicode 10" equal? 17 length? "^(01D122) - The Bass Clef"

;; uppercase not implemented in Red 0.42, use case insensitive compare instead
;;test "Unicode 11" strict-equal? "^(0130)" uppercase "i"
test "Unicode 11" equal? "^(0130)" "i"

;; uppercase not implemented in Red 0.42, use case insensitive compare instead
;;test "Unicode 12" strict-equal? "^(0131)" lowercase "I"
test "Unicode 12" equal? "^(0131)" "I"

;; uppercase not implemented in Red 0.42
;;test "Unicode 13" strict-equal? "STRASSE" uppercase "strat^(00DF)e"
test "Unicode 13" equal? "STRASSE" "strat^(00DF)e"

test "Unicode 14" equal? 1 length? "^(30C8)^(3099)"

test "Unicode 15" equal? 3 length? "e^(0308)^(1D11E)^(30C8)^(3099)"

test "Unicode 16" strict-equal? "weiss" "wei^(00DF)"





print ["Tests:        " passed + failed]
print ["Passed:       " passed]
print ["Failed:       " failed] 
