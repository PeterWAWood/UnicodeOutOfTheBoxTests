# encoding: UTF-8

require 'test/unit'

class TestSource < Test::Unit::TestCase

  def test_unicode_01
    assert_equal("c\xCC\xA7", "\xC3\xA7")  
  end
  
  def test_unicode_02
    assert_not_equal("c\xCC\xA7", "\xC3\xA7")  
  end
  
  def test_unicode_03
    assert_equal(4, "noe\xCC\x88l".length)
  end
  
  def test_unicode_04
    assert_equal("le\xCC\x88on", "noe\xCC\x88l".reverse)
  end
  
  def test_unicode_05
    assert_equal("noe\xCC\x88", "noe\xCC\x88l".slice(0..2))
  end
  
  def test_unicode_06
    assert_equal('BAFFLE', "ba\xEF\xAC\x84e".upcase)
  end
  
  def test_unicode_07
    assert_equal("CANT\xC3\x99", "cant\xC3\xB9".upcase)
  end
  
  def test_unicode_08
    assert_equal("CANTU\xCC\x80", "cantu\xCC\x80".upcase) 
  end
  
  def test_unicode_09
    unicode_string = "\xF0\x9D\x84\x9E - The Treble Clef"
    unicode_string.sub!("\xF0\x9D\x84\x9E", "\xF0\x9D\x84\xA2")
    unicode_string.sub!('Treble', 'Bass')
    assert_equal("\xF0\x9D\x84\xA2 - The Bass Clef", unicode_string)
  end
  
  def test_unicode_10
    assert_equal(17, "\xF0\x9D\x84\xA2 - The Bass Clef".length)
  end
  
  def test_unicode_11
    # as far as I can tell there is no way to set the locale in Ruby
    assert_equal("\xC4\xB0", 'i'.upcase)
  end
  
  def test_unicode_12
    assert_equal("\xC4\xB1", 'I'.downcase)
  end
  
  def test_unicode_13
    assert_equal('STRASSE', "stra\xC3\x9Fe".upcase)
  end
  
  def test_unicode_14
    assert_equal(1, "\xE3\x83\x88\xE3\x82\x99".length)
  end
  
  def test_unicode_15
    assert_equal(3,"e\xCC\x88\xF0\x9D\x84\x9E\xE3\x83\x88\xE3\x82\x99".length)
  end
  
  def test_unicode_16
    assert("wei\xC3\x9Fe".casecmp("weiss"))
  end
  
  def test_unicode_17
    assert_equal("e\xCC\x83\xCD\xBD\xCC\xAA", "e\xCC\xAA\xCC\x83\xCD\x8D")
  end
  
  def test_unicode_18
    assert_equal('XII', "\xE2\x85\xAB")
  end
  
  def test_unicode_19
    assert_not_equal('XII', "\xE2\x85\xAB")
  end
   def test_unicode_20
    assert_equal("\xE1\xB8\x94", "\xE1\xB8\x94")
  end
  
  def test_unicode_21
    assert_equal("E\xCC\x84\xCC\x80", "\xE1\xB8\x94")
  end
  
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
  
end