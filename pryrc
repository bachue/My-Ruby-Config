require 'rubygems'
require 'irb/completion'

begin
  require 'pry'
  Pry.commands.alias_command 'ct', 'continue'
  Pry.commands.alias_command 'st', 'step'
  Pry.commands.alias_command 'nt', 'next'
rescue LoadError, RuntimeError
  # do nothing
end

# Rails hack
if ENV.include?('RAILS_ENV') || defined?(Rails) || ARGV.any? {|arg| arg =~ /config\/environment/}
  require 'logger'

  if !Object.const_defined?('RAILS_DEFAULT_LOGGER')
    RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
  end

  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end

  if ENV['RAILS_ENV'] == 'test'
    begin
      #require 'test/test_helper'
    rescue LoadError
      # do nothing
    end
  end
end
