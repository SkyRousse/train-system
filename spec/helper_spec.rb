require('train')
require('city')
require('stop')
require('pg')
require('rspec')
require('pry')

DB = PG.connect({:dbname => 'train_system_test'})

RSpec.configure do |config|
  config.before(:each) do
    DB.exec('DELETE FROM trains *;')
    DB.exec('DELETE FROM cities *;')
    DB.exec('DELETE FROM stops *;')
  end
  config.after(:each) do
    DB.exec('DELETE FROM trains *;')
    DB.exec('DELETE FROM cities *;')
    DB.exec('DELETE FROM stops *;')
  end
end
