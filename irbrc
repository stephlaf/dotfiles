begin
  require 'rubygems'
  require 'pry'
  require 'csv'
  require 'date'
  require 'time'
  require 'pry-byebug'
  require 'json'
rescue LoadError
end

if defined?(Pry)
  Pry.start
  exit
end
