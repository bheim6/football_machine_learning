require 'rails_helper'

RSpec.feature "User can log in with Github" do
  before(:each) do
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'github',
        info: {
          name: "Sauron",
          nickname: "Morgoth"
        },
        credentials: {
          token: "theonering"
        }
      })
  end

   scenario "User successfully logs in" do
    visit '/'

    expect(page).to have_content('Login')

    click_link 'Login'

    expect(current_path).to eq('/')
    expect(page).to have_content('Hello, Sauron')
    expect(page).to have_content('Successfully Logged In!')
    expect(page).to have_content('Logout')
  end

  scenario "Logged in User can logout" do
    visit '/'
    click_link 'Login'

    expect(current_path).to eq('/')

    click_link 'Logout'

    expect(current_path).to eq('/')
    expect(page).to_not have_content('Hello, Sauron')
    expect(page).to have_content('Login')
  end
end
