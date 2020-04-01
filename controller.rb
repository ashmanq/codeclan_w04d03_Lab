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

# DELETE
get '/students/delete/:id' do
  id = params['id']
  student = Student.find(id)
  student.delete
  redirect('/students')
end

# EDIT
get '/students/:id/edit' do
  id = params['id'].to_i
  @student = Student.find(id)
  @houses = House.find_all()
  erb(:edit)
end



# POST NEW
post '/students' do
  student = Student.new(params)
  student.save()
  redirect to '/students'
end

# POST UPDATE
post '/students/:id' do
  student = Student.new(params)
  student.update()
  redirect('/students')
end
