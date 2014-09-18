require 'sinatra'
require 'data_mapper'

# Setup database #{Dir.pwd}
DataMapper.setup(:default, 'sqlite3:database.db')

# Require all models
Dir['./models/*'].each {|file| require file }

# Finalize database init
DataMapper.finalize

# Require all controllers
Dir['./controllers/*'].each {|file| require file }

run Sinatra::Application
