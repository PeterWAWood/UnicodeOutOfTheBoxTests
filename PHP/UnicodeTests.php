<?php

global $passed; 
global $failed;
$passed = 0;
$failed = 0;
function test($name, $result)
{
    global $passed;
    global $failed;
    if ($result) {
      $passed++;
    } else {
      $failed++;
      print 'Test '.$name." failed\n"; 
    }
}
function reverse($string) {
    $length = grapheme_strlen($string);
    $reversed= '';
    for ($i = 0; $i < $length; $i += 1) {
        $reversed = grapheme_substr($string, $i, 1).$reversed;
    }
    return $reversed;
}


test('Unicode 01', "c\xCC\xA7" == normalizer_normalize("\xC3\xA7", Normalizer::FORM_D));

test('Unicode 02', "c\xCC\xA7" != "\xC3\xA7");

test('Unicode 03', grapheme_strlen("noe\xCC\x88l"));

test('Unicode 04', "le\xCC\x88on" == reverse("noe\xCC\x88l"));

test('Unicode 05', "noe\xCC\x88" == grapheme_extract("noe\xCC\x88l", 3));

test('Unicode 06', 'BAFFLE', mb_strtoupper("ba\xEF\xAC\x84e", 'UTF-8'));

test('Unicode 07', "CANT\xC3\x99", mb_strtoupper("cant\xC3\xB9", 'UTF-8'));

test('Unicode 08', "CANTU\xCC\x80", mb_strtoupper("cantu\xCC\x80", 'UTF-8'));

$unicode_string = "\xF0\x9D\x84\x9E - The Treble Clef";
str_replace("\xF0\x9D\x84\x9E", "\xF0\x9D\x84\xA2", $unicode_string);
str_replace('Treble', 'Bass', $unicode_string);
test('Unicode 09', $unicode_string, "\xF0\x9D\x84\xA2 - The Bass Clef");

test('Unicode 10', 17 == grapheme_strlen("\xF0\x9D\x84\xA2 - The Bass Clef"));

$saved_locale = locale_get_default();
locale_set_default('tr_TR');
test('Unicode 11', "\xC4\xB0" == strtoupper('i'));
locale_set_default($saved_locale);

$saved_locale = locale_get_default();
locale_set_default('tr-TR');
test('Unicode 12', "\xC4\xB1" == strtolower('I'));
locale_set_default($saved_locale);

test('Unicode 13', 'STRASSE', mb_strtoupper("stra\xC3\x9Fe", 'UTF-8'));

test('Unicode 14', 1 == grapheme_strlen("\xE3\x83\x88\xE3\x82\x99"));

test('Unicode 15', 
        3 == grapheme_strlen("e\xCC\x88\xF0\x9D\x84\x9E\xE3\x83\x88\xE3\x82\x99"));
        
$collator = collator_create('de_DE');
test('Unicode 16', collator_compare($collator, "wei\xC3\x9Fe", 'weiss'));

$collator = collator_create('en_UK');
test('Unicode 17', collator_compare($collator, 
                                    "e\xCC\x83\xCD\xBD\xCC\xAA",
                                    "e\xCC\xAA\xCC\x83\xCD\x8D"));
                                    
test('Unicode 18', normalizer_normalize('XII', Normalizer::FORM_KD) ==
                   normalizer_normalize("\xE2\x85\xAB", Normalizer::FORM_KD));

test('Unicode 19', normalizer_normalize('XII', Normalizer::FORM_D) !=
                   normalizer_normalize("\xE2\x85\xAB", Normalizer::FORM_D));
                   
test('Unicode 20', normalizer_normalize("\xE1\xB8\x94", Normalizer::FORM_C) ==
                   normalizer_normalize("\xE1\xB8\x94", Normalizer::FORM_C));
                   
test('Unicode 21', normalizer_normalize("E\xCC\x84\xCC\x80", Normalizer::FORM_D) ==
                   normalizer_normalize("\xE1\xB8\x94", Normalizer::FORM_D));
                   
test('Unicode 22', normalizer_normalize("\xE1\xB8\x94", Normalizer::FORM_C) ==
                   normalizer_normalize("\xC4\x92\xCC\x80", Normalizer::FORM_C));

test('Unicode 23', normalizer_normalize("\xE1\xB8\x94", Normalizer::FORM_D) ==
                   normalizer_normalize("\xC4\x92\xCC\x80", Normalizer::FORM_D));

test('Unicode 24', normalizer_normalize("\xC3\x88\xCC\x84", Normalizer::FORM_C) ==
                   normalizer_normalize("\xC3\x88\xCC\x84", Normalizer::FORM_C));
                   
test('Unicode 25', 
        normalizer_normalize("e\xCC\xAA\xCC\x83\xCD\xBD", Normalizer::FORM_C) !=
        normalizer_normalize("e\xCD\xBD\xCC\xAA\xCC\x83", Normalizer::FORM_C));

print 'Number of Tests    '.($passed + $failed)."\n";
print 'Passed             '.$passed."\n";
print 'Failed             '.$failed."\n";


/*   
  
    
    
   
   
    test("Unicode 24", "\u00C8\u0304".equals(nfc("\u00C8\u0304")));
    
    test("Unicode 25",
        !nfd("e\u0303\u033D\u032A").equals("e\u033D\u032A\u0303"));
  

   
  
 
  def test_unicode_22
    assert_equal("\xE1\xB8\x94", "\xC4\x92\xCC\x80")
  end
  
  def test_unicode_23
    assert_equal("E\xCC\x84\xCC\x80", "\xC4\x92\xCC\x80")
  end
  
  def test_unicode_24
    assert_equal("\xC3\x88\xCC\x84", "\xC3\x88\xCC\x84")
  end
  
  def test_unicode_25
    assert_not_equal("e\xCC\xAA\xCC\x83\xCD\xBD","e\xCD\xBD\xCC\xAA\xCC\x83")
  end
*/
?>