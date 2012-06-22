require 'rubygems'
require 'irb/completion'
require 'map_by_method'
require 'what_methods'
require 'awesome_print'
require 'wirble'
require 'hirb'
require 'pasteboaRb'

Wirble.init
Wirble.colorize
Hirb::View.enable

IRB.conf[:AUTO_INDENT]=true
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 10000
IRB.conf[:EVAL_HISTORY] = 2000

def p(*args); ap *args; end

# Log to STDOUT if in Rails
if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
  #IRB.conf[:USE_READLINE] = true

  # Display the RAILS ENV in the prompt
  # ie : [Development]>> 
  IRB.conf[:PROMPT][:CUSTOM] = {
   :PROMPT_N => "[#{ENV["RAILS_ENV"].capitalize}]>> ",
   :PROMPT_I => "[#{ENV["RAILS_ENV"].capitalize}]>> ",
   :PROMPT_S => nil,
   :PROMPT_C => "?> ",
   :RETURN => "=> %s\n"
   }

  if ENV['RAILS_ENV'] == 'test'
    require 'test/test_helper'
  end

  # Set default prompt
  IRB.conf[:PROMPT_MODE] = :CUSTOM
end

class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
  
  def to_pboard(pboard=:general)
    %x[printf %s "#{self.to_s}" | pbcopy -pboard #{pboard.to_s}]
    paste pboard
  end
  
  alias :to_pb :to_pboard
end

unless IRB.version.include?('DietRB')
  IRB::Irb.class_eval do
    def output_value
      ap @context.last_value
    end
  end
else # MacRuby
  IRB.formatter = Class.new(IRB::Formatter) do
    def inspect_object(object)
      object.ai
    end
  end.new
end
