class Stop
  attr_reader(:id, :train_id, :city_id, :time)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @train_id = attributes.fetch(:train_id)
    @city_id = attributes.fetch(:city_id)
    @time = attributes.fetch(:time)
  end

end
