get '/login' do
  erb :login
end

get '/signin' do
  erb :signin
end

post '/login' do
  if params[:email] and params[:password]
    user = User.first(:email => params[:email])
    if user
      if user.password.eql? params[:password]
        "Welcome #{user.name}!"
      else
        status 401
        "Unauthorized"
      end
    else
      status 404
      "User not found"
    end
  else
    status 400
    "Bad Request"
  end
end

post '/users' do
  if params[:name] and params[:email] and params[:password]
    user = User.new(
      :name => params[:name], 
      :email => params[:email], 
      :password => params[:password]
    )
    if user.save
      status 201
      "OK"
    else
      status 409
      "Problem saving user"
    end
  else
    status 400
    "Bad Request"
  end
end