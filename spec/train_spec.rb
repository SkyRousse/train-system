require('helper_spec')

describe(Train) do
  describe('#name') do
    it ('returns the name of train to user') do
      test_train = Train.new(:name => 'Red', :id => nil)
      expect(test_train.name()).to(eq('Red'))
    end
  end
end
