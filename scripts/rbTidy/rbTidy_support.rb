require 'logger'

@@log = Logger.new('/tmp/logger')
@@log.level = Logger::WARN




class String
  
  def strip_of_non_indent_chars
    repl="__stripped_content__"
    t=self
    # this greedy regex will capture "/regex 1/ and { /regex 2/", causing indenting errors if two regexes appear on the same line with an indenting token between
    t=t.gsub(/\/.*\//,repl)
    t=t.gsub(/\/[^\/]*\//,repl)
    t=t.gsub(/"[^"]*"/,repl)
    t.gsub!(/'[^']*'/,repl)
    t.gsub!(/#[^{]/,repl)
    return t
  end
  
  def remove_consecutive_blank_lines
    self.gsub!(/\n\n\n/,"\n\n")
  end
  
end

class Indent
  @@previous_line=""
  @@indent_token="  "
  
  def self.indent_token
    return @@indent_token
  end
  
  def self.parse(chunk)
    @@first_line     = chunk.split("\n")[0]
    @@current_indent = calculate_indent(@@first_line)
    
    #chunk.remove_consecutive_blank_lines
    result=""
    chunk.collect do |line|
      line.sub!(/\n/, "")
      line=line.strip
      indent if self.check_braces_bias(@@previous_line.strip_of_non_indent_chars) > 0
      outdent if self.check_braces_bias(line.strip_of_non_indent_chars) < 0
      indent if (@@previous_line.match(/else/))
      outdent if (line.match(/else/))
      @@previous_line=line
      apply_indent line
    end.join("\n")
  end
  
  def self.check_braces_bias(line)
    @@log.debug(line)
    open_block = line.scan(/^\s*while\b|\belse\b|^\s*case\b|^\s*when\b|^\s*if\b|^\s*unless\b|\bclass\b|\bmodule\b|\bdef\b|\{|\[|\(|\bdo\b/).size
    close_block= line.scan(/\}|\]|\)|\bthen\b|\belse\b|\bend\b/).size
    @@log.debug(open_block)
    @@log.debug(close_block)
    return open_block - close_block
  end
  
  def self.calculate_indent(first_line)
    if first_line.split(/\w/).empty?
      return 0
      else
      @initial_indent=first_line.split(/\w/)[0].scan(/@@indent_token/).size
      return @initial_indent
    end
  end
  
  def self.indent
    @@current_indent=@@current_indent+1
  end
  
  def self.outdent
    @@current_indent=@@current_indent-1
    @@current_indent=0 if @@current_indent<0
  end
  
  def self.get_indent
    stringin=""
    @@current_indent.times {
      stringin=stringin+@@indent_token
    }
    return stringin
  end
  
  def self.clear_indent(line)
    line.strip
  end
  
  def self.apply_indent(line)
    get_indent + line
  end
  
end
