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
