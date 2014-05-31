! Copyright (C) 2014 Andreas Bolka
! Licensed under the Apache License, Version 2.0.
USING: kernel math namespaces prettyprint sequences splitting
tools.test unicode.breaks unicode.case unicode.normalize ;

{ "\u0000E7" } [ "c\u000327" nfc ] unit-test

{ f } [ "c\u000327" "\u0000E7" = ] unit-test

{ 4 } [ "noe\u000308l" nfc length ] unit-test

{ "le\u000308on" } [ "noe\u000308l" nfc reverse nfd ] unit-test

{ "noe\u000308" } [
    0 3 "noe\u000308l" nfc subseq nfd
] unit-test

{ "BAFFLE" 6 } [ "baﬄe" >upper dup length ] unit-test

{ "CANT\u0000D9" } [ "cant\u0000F9" >upper ] unit-test

{ "CANT\u000300" } [ "cant\u000300" >upper ] unit-test

{ "𝄢 - The Bass Clef" } [
    "𝄞 - The Treble Clef"
        "𝄞" "𝄢" replace
        "Treble" "Bass" replace
] unit-test

{ 17 } [ "𝄢 - The Bass Clef" >graphemes length ] unit-test

{ "İ" } [ "tr" locale [ "i" >upper ] with-variable ] unit-test

{ "STRASSE" } [ "straße" >upper ] unit-test

{ 1 } [ "\u0030C8\u003099" >graphemes length ] unit-test

{ 1 } [ "\u0030C8\u003099" >graphemes length ] unit-test

{ 3 } [
    "e\u000308\u01D11E\u0030C8\u003099" >graphemes length
] unit-test

{ t } [ "weiss" >case-fold "weiß" >case-fold = ] unit-test

{ "e\u00032A\u000303\u00033D" } [
    "e\u000303\u00033D\u00032A" nfd
] unit-test

{ "XII" } [ "\u00216B" nfkd ] unit-test

{ f } [ "XII" "\u00216B" = ] unit-test
