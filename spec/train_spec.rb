require('helper_spec')

describe(Train) do
  describe('#name') do
    it ('returns the name of train to user') do
      test_train = Train.new(:name => 'Red', :id => nil)
      expect(test_train.name()).to(eq('Red'))
    end
  end

  describe('#==') do
    it('compares objects to determine if they are the same') do
      test_train1 = Train.new(:name => 'Blue', :id => nil)
      test_train2 = Train.new(:name => 'Blue', :id => nil)
      expect(test_train1).to(eq(test_train2))
    end
  end

  describe('.all') do
    it('returns empty at first for stored trains') do
      expect(Train.all()).to(eq([]))
    end
  end

end
