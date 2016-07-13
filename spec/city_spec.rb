require('helper_spec')

describe(City)
  describe('#name') do
    it('returns the name of the city') do
      test_city = City.new({:id => nil, :name => "Portland"})
      expect(test_city.name()).to(eq("Portland"))
    end
  end
