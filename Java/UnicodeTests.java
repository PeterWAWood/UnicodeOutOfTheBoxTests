import java.text.Normalizer;
import java.text.Normalizer.Form;
import java.util.Locale;

public class UnicodeTests {

  static int passed = 0;
  static int failed = 0;
  static String testName;
  
  static void testFailed() {
    failed += 1;
    System.out.println("Test " + testName + " failed");
  }
  
  public static void main(String[] args) {
    
    String unicodeString;
    Locale turkish = new Locale("tr", "TR");
    
    testName = "Unicode 1";
    unicodeString = "c\u0327";
    if (Normalizer.normalize(unicodeString, Normalizer.Form.NFC).equals("\u00E7")) {
      passed += 1;
    } else {
      testFailed();
    }
    
    testName = "Unicode 2";
    unicodeString = "c\u0327";
    if (!unicodeString.equals("\u00E7")) {
      passed += 1;
    } else {
      testFailed();
    }
    
    testName = "Unicode 3";
    unicodeString = "noe\u0308l";
    if (unicodeString.codePointCount(0, unicodeString.length()) == 4) {
      passed += 1;
    } else {
      testFailed();
    }
    
    testName = "Unicode 4";
    unicodeString = new StringBuilder("noe\u0308l").reverse().toString();
    if (unicodeString.equals("le\u0308on")) {
      passed += 1;
    } else {
      testFailed();
    }
    
    testName = "Unicode 5";
    unicodeString = "noe\u0308l";
    if ((unicodeString.substring(0,3).equals("noe\u0308")) &&
        (unicodeString.substring(0,3).length() == 3)) {
      passed += 1;
    } else {
      testFailed();
    }
    
    testName = "Unicode 6";
    unicodeString = "ba\uFB04e";
    if (unicodeString.toUpperCase().equals("BAFFLE")) {
      passed += 1;
    } else {
      testFailed();
    }
  
    testName = "Unicode 7";
    unicodeString = "cant\u00F9";
    if (unicodeString.toUpperCase().equals("CANT\u00D9")) {
      passed += 1;
    } else {
      testFailed();
    }
    
    testName = "Unicode 8";
    unicodeString = "cantu\u0300";
    if (unicodeString.toUpperCase().equals("CANTU\u0300")) {
      passed += 1;
    } else {
      testFailed();
    }
    
    testName = "Unicode 9";
    unicodeString = "\uD834\uDD1E - The Treble Clef";
    unicodeString = unicodeString.replace("\uD834\uDD1E", "\uD834\uDD22");
    if (unicodeString.replace("Treble", "Bass").equals("\uD834\uDD22 - The Bass Clef")) {
      passed += 1;
    } else {
      testFailed();
    }   
    
    testName = "Unicode 10";
    unicodeString = "\uD834\uDD22 - The Bass Clef";
    if (unicodeString.codePointCount(0, unicodeString.length()) == 17 ) { 
      passed += 1;
    } else {
      testFailed();
    }   
    
    testName = "Unicode 11";
    unicodeString = "i";
    if (unicodeString.toUpperCase(turkish).equals("\u0130")) {
      passed += 1;
    } else {
      testFailed();
    }
    
    testName = "Unicode 12";
    unicodeString = "I";
    if (unicodeString.toLowerCase(turkish).equals("\u0131")) {
      passed += 1;
    } else {
      testFailed();
    }
    
    testName = "Unicode 13";
    unicodeString = "stra\u00DFe";
    if (unicodeString.toUpperCase().equals("STRASSE")) {
      passed += 1;
    } else {
      testFailed();
    }
    
    testName = "Unicode 14";
    unicodeString = "\u03C8\u3099";
    if (Normalizer.normalize(unicodeString, Normalizer.Form.NFC).length() == 1) {
      passed += 1;
    } else {
      testFailed();
    }
    
    testName = "Unicode 15";
    unicodeString = "e\u0308\uD834\uDD1E\u03C8\u3099";
    if (Normalizer.normalize(unicodeString, Normalizer.Form.NFC).length() == 3) {
      passed += 1;
    } else {
      testFailed();
    }
    
    System.out.println("Tests performed: " + (passed + failed));
    System.out.println("Tests passed:    " + passed);
    System.out.println("Tests failed:    " + failed);
  
  }
  
}
