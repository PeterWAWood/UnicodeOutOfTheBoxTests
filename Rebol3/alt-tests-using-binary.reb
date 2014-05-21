Rebol []

; binary! workarounds
; test 9  - now passes
; test 10 - still fails (requires grapheme cluster handling)
; test 15 - still fails (ditto)

Unicode-tests: [

    ; 1 - test 9
    [
        ;; Rebol can't handle characters above the BMP :(
        ;; However Rebol uses utf-8 for all input/output
        ;; So its binary! all the way :)

        use [got expected] [
            ; {𝄞 - The Treble Clef}
            ;got: #{F09D849E202D2054686520547265626C6520436C6566} ;; alternative
            got: rejoin [#{F09D849E} " - The Treble Clef"]

            ; {𝄢 - The Bass Clef}
            ;expected: #{F09D84A2202D20546865204261737320436C6566} ;; alternative
            expected: rejoin [#{F09D84A2} " - The Bass Clef"]

            replace replace got #{F09D849E} #{F09D84A2} "Treble" "Bass"
            got == expected
        ]
    ]

    ; TBD - create some grapheme cluster counting length for below tests to pass

    ; 2 - test 10 (using utf-8 binary)
    [(length? #{F09D84A2202D20546865204261737320436C6566}) == 17]

    ; 3 - test 15 (using utf-8 binary)
    [(length? #{65CC88F09D849EE38388E38299}) == 3]

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
