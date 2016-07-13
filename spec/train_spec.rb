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

  describe('#save') do
    it('stores a new object of train') do
      test_train1 = Train.new(:name => 'Green', :id => 2)
      test_train1.save()
      expect(Train.all()).to(eq([test_train1]))
    end
  end

  describe('#id') do
    it('returns the train id') do
      test_train1 = Train.new(:name => 'Blue', :id => nil)
      test_train1.save()
      expect(test_train1.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('.find') do
    it('will find a train based on its id') do
      test_train1 = Train.new(:name => 'Blue', :id => nil)
      test_train1.save()
      test_train2 = Train.new(:name => 'Red', :id => nil)
      test_train2.save()
      expect(Train.find(test_train2.id())).to(eq(test_train2))
    end
  end

  describe('#update') do
    it('will update the name of a specific train') do
      test_train1 = Train.new({:name => 'Blue', :id => nil})
      test_train1.save()
      test_train1.update({:name => 'Red'})
      expect(test_train1.name()).to(eq('Red'))
    end
  end
end
