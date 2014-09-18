get '/hi' do
  @message = 'Hello'
  erb :index
end