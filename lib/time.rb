class StopTime
  attr_reader(:id, :stop_time)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @stop_time = attributes.fetch(:stop_time)
  end

end
