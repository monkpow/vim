#!/usr/bin/ruby
require '~/.vim/scripts/rbTidy/rbTidy_support'


#simple wrapper to indent from stdin
puts Indent.parse($stdin.read)
