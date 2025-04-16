begin
  # p 'requiring rubygems'
  require 'rubygems'
  # p 'rubygems required'

  # p 'requiring pry'
  require 'pry'
  # p 'pry required'

  # p 'requiring csv'
  require 'csv'
  # p 'csv required'

  # p 'requiring date'
  require 'date'
  # p 'date required'

  # p 'requiring time'
  require 'time'
  # p 'time required'

  # p 'requiring pry-byebug'
  require 'pry-byebug'
  # p 'pry-byebug required'

  # p 'requiring json'
  require 'json'
  # p 'json required'
rescue LoadError
  p 'Rescued! There was an Error...'
end

if defined?(Pry)
  Pry.start
  exit
end

IRB.conf[:USE_AUTOCOMPLETE] = false
IRB.conf[:USE_PAGER] = false
