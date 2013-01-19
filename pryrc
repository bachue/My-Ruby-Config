require 'rubygems'
require 'irb/completion'

begin
  require 'pry'
  Pry.commands.alias_command 'ct', 'continue'
  Pry.commands.alias_command 'st', 'step'
  Pry.commands.alias_command 'nt', 'next'
rescue LoadError
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
      require 'test/test_helper'
    rescue LoadError
      # do nothing
    end
  end
end

# Hack for Mozy Project
if ENV.include?('RAILS_ENV') || defined?(Rails) || ARGV.any? {|arg| arg =~ /config\/environment/}
  def new_userlist(range = 100)
    (1..range).each {|i| puts "bachue#{i}@qq.com" unless ((users = User.find(:all, { :conditions => {:username => "bachue#{i}@qq.com"} })) && users.any?{|user| user.userhash.present? && user.exists?})}
  end

  def new_adminlist(range = 100)
    (1..range).each {|i| puts "bachue#{i}@qq.com" unless ((admins = Admin.find(:all, { :conditions => {:username => "bachue#{i}@qq.com"} })) && admins.any?{|admin| !admin.deleted_at})}
  end
end
