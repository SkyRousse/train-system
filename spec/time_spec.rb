require ('helper_spec')

describe(StopTime) do
  describe('#stop_time') do
    it('returns the time of stop') do
      test_time = StopTime.new({:id => nil, :stop_time => "08:00:00"})
      expect(test_time.stop_time()).to(eq("08:00:00"))
    end
  end

  describe('#==') do
    it('returns true if two stoptimes are the same') do
      test_stop_time = StopTime.new({:id => 2, :stop_time => "09:00:13"})
      test_stop_time2 = StopTime.new({:id => 2, :stop_time => "09:00:13"})
      expect(test_stop_time).to(eq(test_stop_time2))
    end
  end

  describe('.all') do
    it('returns an empty array for all stop_times at first') do
      expect(StopTime.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a stop time to the database of stop times') do
      test_stop_time = StopTime.new({:id => 2, :stop_time => "09:00:13"})
      test_stop_time.save()
      expect(StopTime.all()).to(eq([test_stop_time]))
    end
  end

end
