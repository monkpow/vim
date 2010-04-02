require 'test/unit'
require 'rbTidy_support'

class TestString < Test::Unit::TestCase
  def test_strip_gnarley_regex
    regex_pattern_for_stripping="t=t.gsub(/\/[^\/]*\//,repl)"
    result=regex_pattern_for_stripping.strip_of_non_indent_chars
    puts result
    assert_equal(0,check_braces_bias(result))
  end
end
