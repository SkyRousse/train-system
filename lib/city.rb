class City
  attr_reader(:id, :name)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_method(:==) do |another_city|
    self.name().eql?(another_city.name()).&(self.id().eql?(another_city.id()))
  end
end
