require ('helper_spec')

describe(StopTime) do
  describe('#stop_time') do
    it('returns the time of stop') do
      test_time = StopTime.new({:id => nil, :stop_time => "08:00:00"})
      expect(test_time.stop_time()).to(eq("08:00:00"))
    end
  end
end
