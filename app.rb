require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/train')
require('./lib/city')
require('./lib/stop')
require('pg')

# DB = PG.connect({:dbname => 'train_system'})

get('/') do
  erb(:index)
end

get('/admin') do
  @trains = Train.all()
  erb(:admin)
end
