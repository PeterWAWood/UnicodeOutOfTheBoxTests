#lang racket

#|
Copyright (C) 2014 Andreas Bolka
Licensed under the Apache License, Version 2.0 (the "License")
|#

(require rackunit)

(define nfc string-normalize-nfc)
(define nfd string-normalize-nfd)
(define nfkd string-normalize-nfkd)

(check-equal? "\u00E7" (nfc "c\u0327"))

(check-not-equal? "\u00E7" "c\u0327")

(check-equal? 4 (string-length (nfc "noe\u0308l")))

(check-equal? "le\u0308on"
              (nfd (list->string (reverse (string->list (nfc "noe\u0308l"))))))

(check-equal? "noe\u0308" (nfd (substring (nfc "noe\u0308l") 0 3)))

(check-true (and (equal? "BAFFLE" (string-upcase "ba\uFB04e"))
                 (equal? 6 (string-length (string-upcase "ba\uFB04e")))))

(check-equal? "CANT\u00D9" (string-upcase "cant\u00F9"))

(check-equal? "CANT\u0300" (string-upcase "cant\u0300"))

(check-equal? "\U01D122 - The Bass Clef"
              (string-replace
               (string-replace
                "\U01D11E - The Treble Clef"
                "\U01D11E"
                "\U01D122")
               "Treble"
               "Bass"))

(check-equal? 17 (string-length "\U01D122 - The Bass Clef"))

(check-equal? "\u0130"
              (parameterize ([current-locale "tr_TR.UTF-8"])
                (string-locale-upcase "i")))

(check-equal? "\u0131"
              (parameterize ([current-locale "tr_TR.UTF-8"])
                (string-locale-downcase "I")))

(check-equal? "STRASSE" (string-upcase "straße"))

;; Needs grapheme clustering.
(check-equal? 1 (string-length "\u30C8\u3099"))

;; Needs grapheme clustering.
(check-equal? 3 (string-length "e\u0308\U01D11E\u30c8\u3099"))

(check string-ci=? "weiss" "weiß")

(check-equal? (nfd "e\u0303\u033D\u032A") "e\u032A\u0303\u033D")

(check-equal? "XII" (nfkd "\u216B"))

(check-not-equal? "XII" "\u216B")
