using System;
using System.Globalization;
using System.Text;
 
public class UnicodeTests {
    private static int failed = 0;
    private static int passed = 0;
    
    private static String nfc(String input) {
        return input.Normalize(NormalizationForm.FormC);
    }

    private static String nfd(String input) {
        return input.Normalize(NormalizationForm.FormD);
    }

    private static String nfkd(String input) {
        return input.Normalize(NormalizationForm.FormKD);
    }

    private static string reverseGraphemes(string uS) {
      string sU = "";
      TextElementEnumerator text = StringInfo.GetTextElementEnumerator(uS);
      text.Reset();
      while (text.MoveNext()) {
        sU = text.GetTextElement() + sU;
      }
      return sU;
    }
    
    private static string substringGraphemes(string uS, int beg, int end) {
    TextElementEnumerator text = StringInfo.GetTextElementEnumerator(uS);
    string subSU = "";
    text.Reset();
    for (int i = 0; i < beg; i++) {
      if (!text.MoveNext()) {return subSU;} 
    }
    for (int i = beg; i < end; i++) {
      if (!text.MoveNext()) {return subSU;}
      subSU = subSU + text.GetTextElement();
    }
    return subSU;
    }
    
    private static void test(string name, bool result) {
        if (result) {
            passed++;
        } else {
            failed++;
            Console.WriteLine("Test " + name + " failed");
        }
    }
    
    static public void Main () {
    
        string uS;
        StringInfo sI;
    
        test("Unicode 1", nfc("c\u0327") == "\u00E7");
        
        test("Unicode 2", "c\u0327" != "\u00E7");
        
        sI = new StringInfo("noe\u0308l");
        test("Unicode 3", sI.LengthInTextElements == 4);
        
        test("Unicode 4", reverseGraphemes("noe\u0308l") == "le\u0308on");
        
        string subUS = substringGraphemes("noe\u0308l", 0, 3);
        sI = new StringInfo(subUS);
        test("Unicode 5", (subUS == "noe\u0308") && (sI.LengthInTextElements == 3));
          
        test("Unicode 6", "ba\uFB04e".ToUpper() == "BAFFLE");
        
        test("Unicode 7", "cant\u00F9".ToUpper() == "CANT\u00D9");

        test("Unicode 8", "cantu\u0300".ToUpper() == "CANTU\u0300");
        
        uS = "\uD834\uDD1E - The Treble Clef";
        uS = uS.Replace("\uD834\uDD1E", "\uD834\uDD22");
        test("Unicode 9", uS.Replace("Treble", "Bass") == "\uD834\uDD22 - The Bass Clef");
        
        sI = new StringInfo("\uD834\uDD22 - The Bass Clef");
        test("Unicode 10", sI.LengthInTextElements == 17);
        
        test("Unicode 11", "i".ToUpper(new CultureInfo("tr-TR", false)) == "\u0130");
        
        test("Unicode 12", "I".ToLower(new CultureInfo("tr-TR", false)) == "\u0131");

        test("Unicode 13", "stra\u00DFe".ToUpper() == "STRASSE");
      
        sI = new StringInfo(nfc("\u03C8\u3099"));
        test("Unicode 14", sI.LengthInTextElements == 1);
        
        sI = new StringInfo(nfc("e\u0308\uD834\uDD1E\u03C8\u3099"));
        test("Unicode 15", sI.LengthInTextElements == 3);
        
        test("Unicode 16", String.Compare("weiss", "weiß") == 0);
        
        test("Unicode 17", nfd("e\u0303\u033D\u032A") == "e\u032A\u0303\u033D");

        test("Unicode 18", "XII" == nfkd("\u216B"));

        test("Unicode 19", "XII" != "\u216B");
    
        test("Unicode 20", "\u1E14" == nfc("\u1E14"));
    
        test("Unicode 21", "E\u0304\u0300" == nfd("\u1E14"));
    
        test("Unicode 22", "\u1E14" == nfc("\u0112\u0300"));
    
        test("Unicode 23", "E\u0304\u0300" == nfd("\u0112\u0300"));   
   
        test("Unicode 24", "\u00C8\u0304" == nfc("\u00C8\u0304"));
        
        test("Unicode 25", nfd("e\u0303\u033D\u032A")!= "e\u033D\u032A\u0303");
            
	      Console.WriteLine("Number of Tests   " + (passed + failed));
        Console.WriteLine("Passed            " + passed);
        Console.WriteLine("Failed            " + failed);
    }
}