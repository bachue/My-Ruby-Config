require 'rubygems'
require 'irb/completion'

begin
  require 'awesome_print'
  def p(*args); ap *args; end
rescue LoadError
  # do nothing
end

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 10000
IRB.conf[:EVAL_HISTORY] = 2000

# Log to STDOUT if in Rails
if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)

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
    begin
      require 'test/test_helper'
    rescue LoadError
      # do nothing
    end
  end

  # Set default prompt
  IRB.conf[:PROMPT_MODE] = :CUSTOM
end
