require ('helper_spec')

describe(Stop) do
  describe('#time') do
    it('returns the time of stop') do
      test_stop = Stop.new({:id => nil, :train_id => 1, :city_id => 1, :time => "12:00:00"})
      expect(test_stop.time()).to(eq("12:00:00"))
    end
  end
end
