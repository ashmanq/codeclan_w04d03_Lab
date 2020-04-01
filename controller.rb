require('sinatra')
require('sinatra/contrib/all')

require_relative('./models/student')
require_relative('./models/house')
also_reload('./models/*')


# INDEX
get '/students' do
  @students = Student.find_all()
  erb(:index)
end

# NEW
get '/students/new' do
  @students = Student.find_all()
  @houses = House.find_all()
  erb(:new)
end



# POST

post '/students' do
  student = Student.new(params)
  student.save()
  redirect to '/students'
end
