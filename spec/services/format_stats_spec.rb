require 'rails_helper'

describe "Api Service" do
  it "can return a stats hash from api call" do
    test_stats = {
      :"1" => 23,
      :"4" => 4,
      :"5" => 340,
      :"20" => 123
    }
    {
      pass_yds: 340,
      rec_made: 123
    }

    formated_stats = FantasyAPIService.format_stats(test_stats)

    expect(formated_stats).to_not have_key(:"1")
    expect(formated_stats).to_not have_key(:"4")
    expect(formated_stats[:pass_yds]).to eq(340)
    expect(formated_stats[:rec_made]).to eq(123)
  end
end
