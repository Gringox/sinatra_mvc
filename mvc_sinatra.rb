if ARGV.length != 1
  puts "Usage: ruby mvc_sinatra.rb NAME"
  exit
end

if File.exists? ARGV[0]
  puts "#{ARGV[0]} already exist"
  exit
end

Dir.mkdir ARGV[0]
Dir.mkdir "#{ARGV[0]}/models"
Dir.mkdir "#{ARGV[0]}/views"
Dir.mkdir "#{ARGV[0]}/controllers"
Dir.mkdir "#{ARGV[0]}/public"
Dir.mkdir "#{ARGV[0]}/public/images"
Dir.mkdir "#{ARGV[0]}/public/js"
Dir.mkdir "#{ARGV[0]}/public/css"

File.open("#{ARGV[0]}/config.ru", "w") { |f| 
  f.write("require 'sinatra'
require 'data_mapper'

# Setup database
DataMapper.setup(:default, 'sqlite3:database.db')

# Require all models
Dir['./models/*'].each {|file| require file }

# Finalize database init
DataMapper.finalize

# Require all controllers
Dir['./controllers/*'].each {|file| require file }

run Sinatra::Application") 
}

File.open("#{ARGV[0]}/Gemfile", "w") { |f| 
  f.write("source 'https://rubygems.org'

gem 'sinatra'
gem 'data_mapper'") 
}

File.open("#{ARGV[0]}/views/layout.erb", "w") { |f| 
  f.write("<!DOCTYPE html>
<html>
  <head>
    <!-- Stuff -->
  </head>
  <body>
    <%= yield %>
  </body>
</html>") 
}

puts "DONE"