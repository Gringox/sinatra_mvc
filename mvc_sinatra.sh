# Validate that $1 and only $1 exist
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 NAME" 
  exit 1
fi

# Validate that "$1" is not repeated
if [ -e "$1" ]; then
  echo "$1 already exist" 
  exit 1
fi

# Create models views, controllers and public folders
mkdir "$1" "$1"/models "$1"/views "$1"/controllers "$1"/public "$1"/public/images "$1"/public/js "$1"/public/css

# Create config.ru
touch "$1"/config.ru
echo "require 'sinatra'
require 'data_mapper'

# Setup database
DataMapper.setup(:default, 'sqlite3:database.db')

# Require all models
Dir['./models/*'].each {|file| require file }

# Finalize database init
DataMapper.finalize

# Require all controllers
Dir['./controllers/*'].each {|file| require file }

run Sinatra::Application" > "$1"/config.ru

# Create Gemfile
touch "$1"/Gemfile
echo "source 'https://rubygems.org'

gem 'sinatra'
gem 'data_mapper'" > "$1"/Gemfile

# Create layout.erb
touch "$1"/views/layout.erb
echo "<!DOCTYPE html>
<html>
  <head>
    <!-- Stuff -->
  </head>
  <body>
    <%= yield %>
  </body>
</html>" > "$1"/views/layout.erb

# All done
echo "DONE"