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
