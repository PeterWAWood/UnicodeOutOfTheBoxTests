# encoding: UTF-8

require 'test/unit'
require 'unicode_utils/canonical_equivalents_q'
require "unicode_utils/casefold"
require 'unicode_utils/downcase'
require 'unicode_utils/each_grapheme'
require 'unicode_utils/nfc'
require 'unicode_utils/nfd'
require 'unicode_utils/nfkd'
require 'unicode_utils/upcase'

class TestSource < Test::Unit::TestCase

  def test_unicode_01
    assert(UnicodeUtils.canonical_equivalents?("c\xCC\xA7", "\xC3\xA7"))  
  end
  
  def test_unicode_02
    assert_not_equal("c\xCC\xA7", "\xC3\xA7")  
  end
  
  def test_unicode_03
    assert_equal(4, UnicodeUtils.each_grapheme("noe\xCC\x88l").count)
  end
  
  def test_unicode_04
    reversed = ''
    UnicodeUtils.each_grapheme("noe\xCC\x88l") { |g| reversed.insert(0, g)}
    assert_equal("le\xCC\x88on", reversed)
  end
  
  def test_unicode_05
    i = 0
    substring = ''
    UnicodeUtils.each_grapheme("noe\xCC\x88l") do |g|
      substring.insert(-1,g) if i < 3
      i += 1
    end 
    assert_equal("noe\xCC\x88", substring)
  end
  
  def test_unicode_06
    assert_equal('BAFFLE', UnicodeUtils.upcase("ba\xEF\xAC\x84e"))
  end
  
  def test_unicode_07
    assert_equal("CANT\xC3\x99", UnicodeUtils.upcase("cant\xC3\xB9"))
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
    assert_equal("\xC4\xB0", UnicodeUtils.upcase("i", :tr))
  end
  
  def test_unicode_12
    assert_equal("\xC4\xB1", UnicodeUtils.downcase("I", :tr))
  end
  
  def test_unicode_13
    assert_equal('STRASSE', UnicodeUtils.upcase("stra\xC3\x9Fe"))
  end
  
  def test_unicode_14
    assert_equal(1, UnicodeUtils.each_grapheme("\xE3\x83\x88\xE3\x82\x99").count)
  end
  
  def test_unicode_15
    assert_equal(3,UnicodeUtils.each_grapheme("e\xCC\x88\xF0\x9D\x84\x9E\xE3\x83\x88\xE3\x82\x99").count)
  end
  
  def test_unicode_16
    assert_equal(UnicodeUtils.casefold("weiss"), UnicodeUtils.casefold("weiß"))
  end
  
  def test_unicode_17
    assert(UnicodeUtils.canonical_equivalents?("e\xCC\xAA\xCC\x83\xCD\xBD","e\xCC\xAA\xCC\x83\xCD\xBD"))
  end
  
  def test_unicode_18
    assert_equal('XII', UnicodeUtils.nfkd("\xE2\x85\xAB"))
  end
  
  def test_unicode_19
    assert_not_equal('XII', UnicodeUtils.nfd("\xE2\x85\xAB"))
  end
  
  def test_unicode_20
    assert_equal("\xE1\xB8\x94", UnicodeUtils.nfc("\xE1\xB8\x94"))
  end
  
  def test_unicode_21
    assert_equal("E\xCC\x84\xCC\x80", UnicodeUtils.nfd("\xE1\xB8\x94"))
  end
  
  def test_unicode_22
    assert_equal("\xE1\xB8\x94", UnicodeUtils.nfc("\xC4\x92\xCC\x80"))
  end
  
  def test_unicode_23
    assert_equal("E\xCC\x84\xCC\x80", UnicodeUtils.nfd("\xC4\x92\xCC\x80"))
  end
  
  def test_unicode_24
    assert_equal("\xC3\x88\xCC\x84", UnicodeUtils.nfc("\xC3\x88\xCC\x84"))
  end
  
  def test_unicode_25
    assert(!UnicodeUtils.canonical_equivalents?("e\xCC\xAA\xCC\x83\xCD\xBD","e\xCD\xBD\xCC\xAA\xCC\x83"))
  end
  
end