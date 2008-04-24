#!/usr/bin/ruby
require 'find'
require 'fileutils'
include FileUtils::Verbose

@extensions_to_clean=%w{
zip
\.gz
dmg
bz2
QFX
hqx
sit
}
@recyclery=ENV["HOME"]+'/.Trash/'

Find.find(ENV["HOME"]+'/Desktop') do |path|
  @extensions_to_clean.each { |pattern|  
    if path =~ /#{pattern}/i
      mv(path,@recyclery)
    end  
  }
end
