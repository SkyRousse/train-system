class Train
  attr_reader(:name, :id)

  define_method (:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_method(:==) do |another_train|
    self.name().==(another_train.name()).&(self.id().==(another_train.id()))
  end

  define_singleton_method (:all) do
    returned_trains = DB.exec("SELECT * FROM trains ORDER BY id ASC;")
    trains = []
    returned_trains.each do |train|
      name = train.fetch("name")
      id = train.fetch("id").to_i()
      trains.push(Train.new({:name => name, :id => id}))
    end
    trains
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO trains (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_singleton_method(:find) do |id|
    train_found = nil
    Train.all().each do |train|
      if train.id().eql?(id)
        train_found = train
      end
    end
    train_found
  end

  define_method(:cities) do
    trains =[]
    results = DB.exec("SELECT city_id FROM stops WHERE train_id = #{self.id()};")
    results.each() do |result|
      city_id = result.fetch('city_id').to_i()
      city = DB.exec("SELECT * FROM cities WHERE id = #{city_id};")
      name = city.first().fetch('name')
      trains.push(City.new({:name => name, :id => city_id}))
    end
    trains
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{@id};")

    attributes.fetch(:city_ids, []).each() do |city_id|
      DB.exec("INSERT INTO stops (city_id, train_id ) VALUES (#{city_id}, #{self.id()});")
    end
  end

  define_method(:remove) do
    @id = self.id()
    DB.exec("DELETE from trains WHERE id = #{@id}")
  end
end
