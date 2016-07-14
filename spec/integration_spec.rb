require('helper_spec')
require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('view trains path', {:type => :feature}) do
  it('lists out all the trains in the database') do
    visit('/')
    click_link('Admin')
    expect(page).to have_content("There are no trains in the database; Add a train below")
    click_link('Add train')
    fill_in('name', :with => 'Red')
    click_button('Add')
    expect(page).to have_content("Red")
  end
end

describe('edit an existing train path', {:type => :feature}) do
  it('updates a train in the database with user input from a form') do
    test_train = Train.new(:name => 'Red', :id => nil)
    test_train.save()
    visit('/admin')
    click_link("#{test_train.id()}")
    fill_in('name', :with => 'Blue')
    click_button('Update')
    expect(page).to have_content("Blue")
  end

  describe('remove a train path', {:type => :feature}) do
    it('removes a train from the database') do
      test_train = Train.new(:name => 'Red', :id => nil)
      test_train.save()
      visit('/admin')
      click_link("#{test_train.id()}")
      click_button('Remove')
      expect(page).to have_content("There are no trains in the database; Add a train below")
    end
  end
end

describe('view cities path', {:type => :feature}) do
  it('list out all of the cities in the database') do
    visit('/')
    click_link('Admin')
    expect(page).to have_content("There are no cities in the database; Add a city below")
    click_link('Add city')
    fill_in('name', :with => 'Portland')
    click_button('Add')
    expect(page).to have_content("Portland")
  end
end

describe('update cities path', {:type => :feature}) do
  it('updates the name of a city') do
    test_city = City.new(:id => nil, :name => 'Eugene')
    test_city.save()
    visit('/admin')
    click_link("#{test_city.name()}")
    fill_in('name', :with => 'Salem')
    click_button('Update')
    expect(page).to have_content("Salem")
  end
end

describe('delete cities path', {:type => :feature}) do
  it('removes a city from the cities table') do
    test_city = City.new(:id => nil, :name => 'Eugene')
    test_city.save()
    visit('/admin')
    click_link("#{test_city.name()}")
    click_button('Remove')
    expect(page).to have_content("There are no cities in the database; Add a city below")
  end
end

describe('train to cities join path', {:type => :feature}) do
  it('joins trains and cities in the stops table') do
    test_train = Train.new(:name => 'Red', :id => nil)
    test_train.save()
    test_city = City.new(:id => nil, :name => 'Eugene')
    test_city.save()
    visit("/trains/#{test_train.id()}/edit")
    check('city_ids[]')
    click_button('Add city')
    expect(page).to have_content("Eugene")
  end
end
