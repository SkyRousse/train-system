class StopTime
  attr_reader(:id, :stop_time)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @stop_time = attributes.fetch(:stop_time)
  end

  define_method(:==) do |another_stop_time|
    self.id().==(another_stop_time.id())
    self.stop_time().==(another_stop_time.stop_time())
  end

  define_singleton_method(:all) do
    returned_stop_times = DB.exec("SELECT * FROM stop_times ORDER BY stop_time ASC;")
    stop_times = []
    returned_stop_times.each do |time|
      stop_time = time.fetch("stop_time")
      id = time.fetch("id").to_i()
      stop_times.push(StopTime.new({:id => id, :stop_time => stop_time}))
    end
    stop_times
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stop_times (stop_time) VALUES ('#{@stop_time}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end


end
