require 'rubygems'
begin
  require 'pry'
  Pry.commands.alias_command 'ct', 'continue'
  Pry.commands.alias_command 'st', 'step'
  Pry.commands.alias_command 'nt', 'next'
rescue LoadError
  # do nothing
end
