import java.text.BreakIterator;
import java.text.Collator;
import java.text.Normalizer;
import java.text.Normalizer.Form;
import java.util.Locale;

public class UnicodeTests {

  static int passed = 0;
  static int failed = 0;
  static String testName;
  
  static void test(String name, boolean result) {
    if (result) {
      passed++;
    } else {
      failed++;
      System.out.println("Test " + name + " failed");
    }
  }

  static int countGraphemes(String input) {
    BreakIterator graphemes = BreakIterator.getCharacterInstance();
    graphemes.setText(input);
    int n = 0;
    while (graphemes.next() !=  BreakIterator.DONE) {
        n++;
    }
    return n;
  }

  static String reverseGraphemes(String input) {
    BreakIterator graphemes = BreakIterator.getCharacterInstance();
    graphemes.setText(input);
    StringBuilder result = new StringBuilder();
    int end = graphemes.last();
    int beg = graphemes.previous();
    for (; beg != BreakIterator.DONE; end = beg, beg = graphemes.previous()) {
        result.append(input.substring(beg, end));
    }
    return result.toString();
  }

  static String substringGraphemes(String input, int beg, int end) {
    BreakIterator graphemes = BreakIterator.getCharacterInstance();
    graphemes.setText(input);
    return input.substring(graphemes.next(0), graphemes.next(end));
  }

  public static void main(String[] args) {
    
    String unicodeString;
    Locale turkish = new Locale("tr", "TR");
    Locale german = new Locale("de", "DE");
    
    test("Unicode 1", Normalizer.normalize("c\u0327", Normalizer.Form.NFC).equals("\u00E7"));
    
    test("Unicode 2", !"c\u0327".equals("\u00E7"));
    
    test("Unicode 3", countGraphemes("noe\u0308l") == 4);
    
    test("Unicode 4", reverseGraphemes("noe\u0308l").equals("le\u0308on"));
    
    test("Unicode 5", substringGraphemes("noe\u0308l", 0, 3).equals("noe\u0308")
                      && countGraphemes(substringGraphemes("noe\u0308l", 0, 3)) == 3);
            
    test("Unicode 6", "ba\uFB04e".toUpperCase().equals("BAFFLE"));
    
    test("Unicode 7", "cant\u00F9".toUpperCase().equals("CANT\u00D9"));
    
    test("Unicode 8", "cantu\u0300".toUpperCase().equals("CANTU\u0300"));
    
    unicodeString = "\uD834\uDD1E - The Treble Clef";
    unicodeString = unicodeString.replace("\uD834\uDD1E", "\uD834\uDD22");
    test("Unicode 9", unicodeString.replace("Treble", "Bass")
                                    .equals("\uD834\uDD22 - The Bass Clef"));
    
    test("Unicode 10", "\uD834\uDD22 - The Bass Clef".codePointCount(
                        0, "\uD834\uDD22 - The Bass Clef".length()) == 17 );
                                                      
    
    test("Unicode 11", "i".toUpperCase(turkish).equals("\u0130"));
    
    test("Unicode 12", "I".toLowerCase(turkish).equals("\u0131"));
    
    test("Unicode 13", "stra\u00DFe".toUpperCase().equals("STRASSE"));
    
    test("Unicode 14", countGraphemes(Normalizer.normalize("\u03C8\u3099", 
                                      Normalizer.Form.NFC)) == 1);
    
    test("Unicode 15", countGraphemes(
                          Normalizer.normalize("e\u0308\uD834\uDD1E\u03C8\u3099", 
                          Normalizer.Form.NFC)) == 3); 
    
    Collator deCollator = Collator.getInstance(german);
    test("Unicode 16", deCollator.compare("weiss", "weiß") == 0);
    
    System.out.println("Tests performed: " + (passed + failed));
    System.out.println("Tests passed:    " + passed);
    System.out.println("Tests failed:    " + failed);
  
  }
  
}
