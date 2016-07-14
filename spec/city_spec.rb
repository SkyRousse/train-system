require('helper_spec')

describe(City) do
  describe('#name') do
    it('returns the name of the city') do
      test_city = City.new({:id => nil, :name => "Portland"})
      expect(test_city.name()).to(eq("Portland"))
    end
  end
  describe("#==") do
    it('returns true if two cities are the same') do
      test_city1 = City.new({:id => 7, :name => "Portland"})
      test_city2 = City.new({:id => 7, :name => "Portland"})
      expect(test_city1).to(eq(test_city2))
    end
  end

  describe('.all') do
    it('returns empty array') do
      expect(City.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('save a city to our table of stored cities') do
      test_city1 = City.new({:id => 7, :name => 'Portland'})
      test_city1.save()
      expect(City.all()).to(eq([test_city1]))
    end
  end

  describe('.find') do
    it('returns a city by finding its id') do
      test_city1 = City.new({:id => 7, :name => 'Portland'})
      test_city1.save()
      expect(City.find(test_city1.id())).to(eq(test_city1))
    end
  end

  describe('#id') do
    it('returns the id of a city') do
      test_city = City.new({:id => nil, :name => "Portland"})
      test_city.save()
      expect(test_city.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#trains') do
    it('returns a list of all trains that stop at a city') do
      test_city = City.new({:id => nil, :name => "Portland"})
      test_city.save()
      test_train1 = Train.new(:name => 'Blue', :id => nil)
      test_train1.save()
      test_train2 = Train.new(:name => 'Red', :id => nil)
      test_train2.save()
      test_city.update(:train_ids => [test_train1.id(), test_train2.id()])
      expect(test_city.trains()).to(eq([test_train1, test_train2]))
    end
  end

  describe('#update') do
    it('updates the name of a city') do
      test_city = City.new({:id => nil, :name => "Portland"})
      test_city.save()
      test_train1 = Train.new(:name => 'Blue', :id => nil)
      test_train1.save()
      test_train2 = Train.new(:name => 'Red', :id => nil)
      test_train2.save()
      test_city.update({:train_ids => [test_train1.id(), test_train2.id()]})
      expect(test_city.trains()).to(eq([test_train1, test_train2]))
    end
  end

  describe("#remove") do
    it('removes specified city from the database') do
      test_city = City.new({:id => nil, :name => "Portland"})
      test_city.save()
      test_city.remove()
      expect(City.all()).to(eq([]))
    end
  end
end
