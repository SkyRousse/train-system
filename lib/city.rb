

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
      name = city.fetch("name")
      id = city.fetch("id").to_i()
      cities.push(City.new({:id => id, :name => name}))
    end
    cities
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO cities (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_singleton_method(:find) do |id|
    found_city = nil
    City.all().each() do |city|
      if city.id().eql?(id)
       found_city = city
      end
    end
    found_city
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    @returned_train_id
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{@id};" )

    attributes.fetch(:train_ids, []).each() do |train_id|
      result = DB.exec("INSERT INTO stops (train_id, city_id) VALUES (#{train_id}, #{self.id()}) RETURNING train_id;")
      @returned_train_id = result.first().fetch("train_id").to_i()
    end
    attributes.fetch(:stop_time_ids, []).each() do |stop_time_id|
      DB.exec("UPDATE stops SET stop_time_id = #{stop_time_id} WHERE city_id = #{self.id()} AND train_id = #{@returned_train_id};")
    end
  end

  define_method(:trains) do
    city_trains = []
    results = DB.exec("SELECT train_id FROM stops WHERE city_id = #{self.id()};")
    results.each do |result|
      train_id = result.fetch("train_id").to_i()
      train = DB.exec("SELECT * FROM trains WHERE id = #{train_id};")
      name = train.first().fetch("name")
      city_trains.push(Train.new({:name => name, :id => train_id}))
    end
    city_trains
  end

  define_method(:stops) do |train_id|
    city_stops = []
    results = DB.exec("SELECT stop_time_id FROM stops WHERE city_id = #{self.id()} AND train_id = #{train_id};")
    results.each do |result|
      stop_time_id = result.fetch("stop_time_id").to_i()
      returned_stop_time = DB.exec("SELECT * FROM stop_times WHERE id = #{stop_time_id};")
      stop_time = returned_stop_time.first().fetch("stop_time")
      city_stops.push(StopTime.new({:stop_time => stop_time, :id => stop_time_id}))
    end
    city_stops
  end

  define_method(:remove) do
    @id = self.id()
    DB.exec("DELETE FROM stops WHERE city_id = #{@id};")
    DB.exec("DELETE FROM cities WHERE id = #{@id};")
  end
end
