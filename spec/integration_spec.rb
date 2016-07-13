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
