package main

import "fmt"
import "unicode"
import "unicode/utf8"
import "strings"

var passed int = 0
var failed int = 0

func reverse(s string) string {
    p := []rune(s);
    r := make([]rune, len(p));
    j := len(p);
    for i := 0; i < len(p); {
      j--;
      r[i] = p[j]
      i++;
    }
    return (string(r[0:]))
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
  
  test("Unicode 4", "le\u0308on" == reverse("noe\u0308l"));
  
  test("Unicode 5", "noe\u0308l"[0:3] == "noe\u0308");
    
  test("Unicode 6", strings.ToUpper("ba\uFB04e") == "BAFFLE");
  
  test("Unicode 7", "CANTu00D9" == strings.ToUpper("CANT\u00F9"));
    
  test("Unicode 8", "CANTU\u0300" == strings.ToUpper("canut\u0300"));
  
  unicodeString := "\u1D11E - The Treble Clef";
  unicodeString = strings.Replace(unicodeString, "\u1D11E", "\u1D122", 1);
  unicodeString = strings.Replace(unicodeString, "Treble", "Bass", 1);  
  test("Unicode 9", unicodeString == "\u1D122 - The Bass Clef");
    
  test("Unicode 10", utf8.RuneCountInString("\u1D122 - The Bass Clef") == 17); 
  
  test("Unicode 11", "\u0130" == strings.ToUpperSpecial(unicode.TurkishCase, "i"));
  
  test("Unicode 12", "\u0131" == strings.ToLowerSpecial(unicode.TurkishCase, "I"));
  
  test("Unicode 13", "STRASSE" == strings.ToUpper("stra\u00DFe"));
  
  test("Unicode 14", utf8.RuneCountInString("\u03C8\u3099") == 1);
  
  test("Unicode 15", utf8.RuneCountInString("e\u0308\u1D11E\u03C8\u3099") == 3);
  
  test("Unicode 16", strings.EqualFold("weiss", "wei\u00DF"));
   
  fmt.Printf("passed %d, failed %d\n", passed, failed);
}