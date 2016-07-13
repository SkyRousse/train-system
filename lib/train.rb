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

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    @id = self.id()
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:remove) do |attributes|
    @id = self.id()
    DB.exec("DELETE * from trains WHERE id = #{@id}")
  end
end
