get '/tasks' do
  @tasks = Task.all
  if @tasks
    erb :task
  else
    status 404
    "Not Found"
  end
end
 
get '/tasks/:id' do
  task = Task.get(params[:id])
  if task
    "<p>Task name: #{task.name}</p><p>Task completed at: #{task.completed_at}</p>"
  else
    status 404
    "Not Found"
  end
end
 
post '/tasks' do
  Task.new(:name => params[:name]).save
  status 201
  "Created"
end
 
put '/tasks/:id' do
  task = Task.get(params[:id])
  task.completed_at = params[:completed] ? Time.now : nil
  task.save
  "Updated"
end
 
delete '/tasks/:id' do
  Task.get(params[:id]).destroy
  status 204
  ""
end