#!/usr/local/bin/ruby

@current_indent=0 
@previous_line=""
@first_line=nil

class String
	def strip_of_non_indent_chars
		repl="__stripped_content__"
		t=self
		t=t.gsub(/\/[^\/]*\//,repl)
			t=t.gsub(/"[^"]*"/,repl)
			t.gsub!(/'[^']*'/,repl)
			t.gsub!(/#[^{]/,repl)
			return t
end
end

def log(line)
	a=File.open('/tmp/rbTidyLog.txt','a')
	a.puts(line)
end

def indent
  log('called indent')
	@current_indent=@current_indent+1
end

def outdent
  log('called outdent')
	@current_indent=@current_indent-1
	@current_indent=0 if @current_indent<0 
end

def get_indent
	stringin=""
	@current_indent.times {
		stringin=stringin+"\t"
	}
	return stringin
end

def clear_indent(line)
	line.gsub!(/^\s*/,"")
	return line
end

def debug(line)
	log "prev_indent: #{@current_indent} | bias: #{check_braces_bias(line)} | #{line}"
end

def prints(line)
	puts get_indent + line
end


def strip_strings_etc(line)
	return line.strip_of_non_indent_chars
end

def calculate_original_indent(first_line)
	@initial_indent=first_line.split(/\w/)[0].scan(/\t/).size
	@current_indent=@initial_indent.to_i
end

def check_braces_bias(line)
	open_block = line.scan(/^\s*while\b|^\s*if\b|^\s*unless\b|\bclass\b|\bmodule\b|\bdef\b|\{|\[|\(|\bdo\b/).size  
	close_block= line.scan(/\}|\]|\)|\bend\b/).size
	return open_block - close_block
end


while(line=gets)
	if @first_line.nil?
		@first_line=line
		calculate_original_indent line
	end
	next if line =~ /^\s*$/ && @previous_line =~ /^\s*$/       # removes multiple white lines
  debug line
	clear_indent(line)
	
	# now all formatting operations are complete, and we're determining indent and outdent
	# need to ignore special characters appearing inside quotes and regexp and comments
	# then pass to indent, outdent expressions
	
	stripped_line=strip_strings_etc(line)
	stripped_previous_line=strip_strings_etc(@previous_line)

  indent if check_braces_bias(stripped_previous_line) > 0   
  log @previous_line
  log check_braces_bias(stripped_previous_line).to_s 
  log stripped_previous_line
	outdent if check_braces_bias(stripped_line) < 0 
	
	prints line
	@previous_line=line
end
