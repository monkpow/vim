#!/usr/bin/ruby

@shift_width=2
@softtabs=true
@current_indent=0 
@previous_line=""
@first_line=nil


def indent
  @current_indent=@current_indent+1
end

def outdent
  @current_indent=@current_indent-1
  @current_indent=0 if @current_indent<0 
end

def get_indent
  stringin=""
  @current_indent.times {
    stringin=stringin+"  "
  }
  return stringin
end

def clear_indent(line)
  line.gsub!(/^\s*/,"")
  return line
end

def prints(line)
  puts get_indent + line
end

def strip_strings_etc(line)
  t=line.gsub(/"[^"]*"/,"");
  t.gsub!(/'[^']*'/,'');
  #t.gsub!(/\/[^\/]*\//,'');
  t.gsub!(/\/\/*$/,'');
  return t
end

#reverse_function_literal  
# current fails on  geocoder.getLatLng(m.value,function(point) {
#if line =~ /^(function)\s*([^(]*)(.*)/
#line= "#{$2} = #{$1}#{$3}"
#end

def break_up_lines_with_semi_colons(line)
  # will also solve for unbalanced lines like
  # d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  # Fails on lines like
  # anchor.setAttribute("style","display:block;text-decoration:underline;font-size:1.3em"); 
  return
  if line.split(/;/).length > 2  
    if line.match(/for/)==nil
      line.gsub!(/;/,";\n")
    elsif line.match(/;\s*for/)
      line.gsub!(/;\s*for/,";\nfor")
      end
    end
    end

    def break_up_one_line_for_and_if (line)
      #  if line =~ /for\s*\([^\)]*\)/
      #  end
    end

    def add_white_space_to_punctuation(line)
      line.gsub!(/(for|if)\(/, '\1 (')
                 #             line.gsub!(/(\S)(==|&&)/,' \1 \2')
                 #             line.gsub!(/(==|&&)(\S)/,' \1 \2')
                 #
                 #        line.gsub!(/[^\s]+\&\&/,'\1 &&') 
                 #  line.gsub!(/([a-z]|[A-Z])(\(|\&|=)/,'\1 \2');
                 #  line.gsub!(/(\(|\&|=)([a-z]|[A-Z])/,'\1 \2');
    end

    def calculate_original_indent(first_line)
       @initial_indent=first_line.split(/\w/)[0].scan(/\t/).size
       @current_indent=@initial_indent.to_i
        #my_file = File.open("/tmp/js_format_log", 'a') 
        #my_file.print first_line +":"+ @initial_indent.to_s
    end

    while(line=gets)
      if @first_line.nil?
        @first_line=line
        calculate_original_indent line
      end



      break_up_lines_with_semi_colons(line)      
      break_up_one_line_for_and_if (line)
      add_white_space_to_punctuation(line) 
      clear_indent(line)

      #reverse_function_literal  
      #if line =~ /^(function)\s*([^(]*)(.*)/
                                 #line= "#{$2} = #{$1}#{$3}"
      #end

      next if line =~ /^\s*$/ && @previous_line =~ /^\s*$/       # removes multiple white lines

        #add semi-colon
        #if line =~ /(;|\(|\)|\{|\}|\]|\[)\s*$/
        #  line = line.gsub(/$/,";$")
        #end

        #comment
        if line =~ /^\s*\// 
          prints line 
      next
        end

      # now all formatting operations are complete, and we're determining indent and outdent
      # need to ignore special characters appearing inside quotes and regexp and comments
      # then pass to indent, outdent expressions

      stripped_line=strip_strings_etc(line)
      stripped_previous_line=strip_strings_etc(@previous_line)

      indent if stripped_previous_line =~ /\{\s*($|\/)/ ||
        stripped_previous_line =~ /\([^\)]*$/   || 
        stripped_previous_line =~ /\[[^\]]*$/

        outdent if stripped_line =~ /^\s*\}/    ||
        stripped_line =~ /^[^(]*\)/  || 
        stripped_line =~ /^[^\[]*\]/ 

        prints line
      @previous_line=line

    end
