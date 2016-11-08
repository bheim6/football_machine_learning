require 'rails_helper'

RSpec.feature "Visitor can visit root page and see navbar" do
  it "with app name" do
    visit '/'

    within('.navbar') do
      expect(page).to have_content("Mind On The Ball")
      expect(page).to have_content("Login")
    end
  end
end
