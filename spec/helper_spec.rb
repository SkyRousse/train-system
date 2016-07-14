require('train')
require('city')
require('time')
require('pg')
require('rspec')
require('pry')

DB = PG.connect({:dbname => 'train_system_test'})

RSpec.configure do |config|
  config.before(:each) do
    DB.exec('DELETE FROM trains *;')
    DB.exec('DELETE FROM cities *;')
    DB.exec('DELETE FROM stops *;')
    DB.exec('DELETE FROM times *;')
  end
  config.after(:each) do
    DB.exec('DELETE FROM trains *;')
    DB.exec('DELETE FROM cities *;')
    DB.exec('DELETE FROM stops *;')
    DB.exec('DELETE FROM times *;')
  end
end
