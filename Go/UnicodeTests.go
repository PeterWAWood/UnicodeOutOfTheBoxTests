package main

import "fmt"
import "unicode"
import "unicode/utf8"
import "strings"

var passed int = 0
var failed int = 0

// This function taken from rosettacode.org
// reversePreservingCombiningCharacters interprets its argument as UTF-8
// and ignores bytes that do not form valid UTF-8.  return value is UTF-8.
func reversePreservingCombiningCharacters(s string) string {
    if s == "" {
        return ""
    }
    p := []rune(s)
    r := make([]rune, len(p))
    start := len(r)
    for i := 0; i < len(p); {
        // quietly skip invalid UTF-8
        if p[i] == utf8.RuneError {
            i++
            continue
        }
        j := i + 1
        for j < len(p) && (unicode.Is(unicode.Mn, p[j]) ||
            unicode.Is(unicode.Me, p[j]) || unicode.Is(unicode.Mc, p[j])) {
            j++
        }
        for k := j - 1; k >= i; k-- {
            start--
            r[start] = p[k]
        }
        i = j
    }
    return (string(r[start:]))
}

func substring(s string, start int, count int) string {
  p := []rune(s);
  r := make([]rune, len(p));
  copied := 0;
  runes_copied := 0;
  for i := start; i < len(p) && copied < count; {
    r[i] = p[i];
    i++;
    runes_copied++;
    copied += 1;
    for i < len(p) && (unicode.Is(unicode.Mn, p[i]) ||
            unicode.Is(unicode.Me, p[i]) || unicode.Is(unicode.Mc, p[i])) {
      r[i] = p[i];
      i++
      runes_copied++;
    }
  }
  return(string(r[start:runes_copied]));
}

func test(name string, result bool) {
  if result {
    passed += 1;
  } else {
    failed += 1;
    fmt.Printf("Test %s failed\n", name);
  }
}

func main() {
  
  test("Unicode 1", "c\u0327" == "\u00E7");
  
  test("Unicode 2", "c\u0327" != "\u00E7");
  
  test("Unicode 3", utf8.RuneCountInString("noe\u0308l") == 4);
  
  test("Unicode 4", "le\u0308on" == reversePreservingCombiningCharacters("noe\u0308l"));
  
  test("Unicode 5", substring("noe\u0308l", 0, 3) == "noe\u0308");
    
  test("Unicode 6", strings.ToUpper("ba\uFB04e") == "BAFFLE");
  
  test("Unicode 7", "CANTu00D9" == strings.ToUpper("CANT\u00F9"));
    
  test("Unicode 8", "CANTU\u0300" == strings.ToUpper("canut\u0300"));
  
  unicodeString := "\u1D11E - The Treble Clef";
  unicodeString = strings.Replace(unicodeString, "\u1D11E", "\u1D122", 1);
  unicodeString = strings.Replace(unicodeString, "Treble", "Bass", 1);  
  test("Unicode 9", unicodeString == "\u1D122 - The Bass Clef");
    
  test("Unicode 10", utf8.RuneCountInString("\u1D122 - The Bass Clef") == 17);  
  
  fmt.Printf("passed %d, failed %d\n", passed, failed);
}