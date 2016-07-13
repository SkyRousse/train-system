require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/train')
require('./lib/city')
require('./lib/stop')
require('pg')

DB = PG.connect({:dbname => 'train_system_test'})

get('/') do
  erb(:index)
end

get('/admin') do
  @trains = Train.all()
  erb(:admin)
end

get('/trains/new') do
  erb(:train_form)
end

post('/admin') do
  name = params.fetch("name")
  new_train = Train.new(:name => name, :id => nil)
  new_train.save()
  @trains = Train.all()
  erb(:admin)
end
