Rebol []

Unicode-tests: [

    ; test 1
    ["c^(0327)" == "^(00E7)"]

    ; test 2
    ["c^(0327)" != "^(00E7)"]

    ; test 3
    [(length? "noe^(0308)l") = 4]

    ; test 4
    [(reverse "noe^(0308)l") == "le^(0308)on"]

    ; test 5
    [(copy/part "noe^(0308)l" 3) == "noe^(0308)"] 

    ; test 6
    [(uppercase "ba^(FB04)e") == "BAFFLE"]

    ; test 7
    [(uppercase "cant^(00F9)") == "CANT^(00D9)"]

    ; test 8
    [(uppercase "cantu^(0300)") == "CANTU^(0300)"]

    ; test 9
    [
        ;; Rebol strings can't handle characters above the BMP :(
        ;;
        ;; NB. See alt-tests-using-binary for workaround

        use [got expected] [
            got: {𝄞 - The Treble Clef}
            expected: {𝄢 - The Bass Clef}

            ;replace replace got "𝄞" "𝄢" "Treble" "Bass"
            ;
            ; Above replace works and will pass the test.  
            ; However Rebol is actually seeing:
            ;   𝄞  as  턞
            ;   𝄢  as  턢

            ; so below uses binary! & utf-8 code units and so wont find 𝄞 in got string:(
            got: to-string replace replace to-binary got #{F09D849E} #{F09D84A2} "Treble" "Bass"
            got == expected
        ]
    ]

    ; test 10 
    [
        (length? {𝄢 - The Bass Clef})  == 17
        false  ; above incorrectly passes because of Rebol BMP issue.  For force the failure
    ]

    ;; NB. Tests 11 & 12 need a locale context (to tr_TR)
    ;;     Currently not available/working in Rebol 3

    ; test 11
    [(uppercase "i") == "^(0130)"]
    
    ; test 12
    [(lowercase "I") == "^(0131)"]
    
    ; test 13
    [(uppercase "stra^(00DF)e") == "STRASSE"]

    ; test 14
    [(length? "^(30C8)^(3099)") == 1]

    ; test 15 
    [(length? to-string #{65CC88F09D849EE38388E38299}) == 3]

    ; test 16 (Rebol 3 doesn't have case folding option)
    [false]
]


;; test runner
tests: map-each t Unicode-tests [do t]

;; test printer
print "Testing..."
failed: 0
forall tests [
    if tests/1 == false [
        ++ failed
        print ["... test" index? tests "failed" mold pick Unicode-tests index? tests]       
    ]
]

;; test summary
either zero? failed [
    print ["All" length? Unicode-tests "tests passed"]
][
    print [failed "out of" length? Unicode-tests "tests failed"]
]
