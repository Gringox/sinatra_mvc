class Task
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :required => true
  property :completed_at, DateTime
end