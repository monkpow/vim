require 'test/unit'
require 'rbTidy_support'


TOK = Indent.indent_token

class TestString < Test::Unit::TestCase
  def test_strip_gnarley_regex
    regex_pattern_for_stripping="t=t.gsub(/\/[^\/]*\//,repl)"
    result=regex_pattern_for_stripping.strip_of_non_indent_chars
    assert_equal(0,Indent.check_braces_bias(result))
  end
  
  def test_non_destructive
    test_string="ABCDEFGHIJKLMNOPQRSTUVWYZ"
    assert_equal(test_string, Indent.parse(test_string))
  end
  
  def test_def_is_formatted_correctly
    test_string   = "def strip_strings_etc(line)\nreturn line.strip_of_non_indent_chars\nend"
    result_string = "def strip_strings_etc(line)\n#{Indent.indent_token}return line.strip_of_non_indent_chars\nend"
    assert_equal(result_string, Indent.parse(test_string))
  end
  
  
  def test_complex_class_with_next
    current_test="class String\n#{Indent.indent_token}\n#{Indent.indent_token}def strip_of_non_indent_chars\n#{Indent.indent_token}#{Indent.indent_token}line\n#{Indent.indent_token}end\nend"
    number_of_lines_before=current_test
    number_of_lines_after=Indent.parse(current_test)
    assert_equal(number_of_lines_before, number_of_lines_after)
  end
  
  
  def test_c_ase_statement
  test_string = "case \n when '302'\n puts 'ok' \n else\n puts 'not' \n end\n end\n"
  result_string = "case\n#{TOK}when '302'\n#{TOK}#{TOK}puts 'ok'\n#{TOK}else\n#{TOK}#{TOK}puts 'not'\n#{TOK}end\nend"
    assert_equal(result_string, Indent.parse(test_string))
  end
  
  
  #def test_remove_multiple_blank_lines
  #test_string   = "line1\n\nline2\n\n\nline3\n\n\nline4"
  #result_string = "line1\n\nline2\n\nline3\n\nline4"
  #assert_equal(result_string, Indent.ndo(test_string))
  #end
end
