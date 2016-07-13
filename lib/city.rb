class City
  attr_reader(:id, :name)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_method(:==) do |another_city|
    self.name().eql?(another_city.name()).&(self.id().eql?(another_city.id()))
  end

  define_singleton_method(:all) do
    returned_cities = DB.exec("SELECT * from cities ORDER by name ASC;")
    cities = []
    returned_cities.each() do |city|
      name = city.name()
      id = city.id()
      cities.push(City.new({:id => id, :name => name}))
    end
    cities
  end
end
