require 'sinatra'

# Require all models
Dir["./app/models/*"].each {|file| require file }

# require all controllers
Dir['./controllers/*'].each {|file| require file }

run Sinatra::Application