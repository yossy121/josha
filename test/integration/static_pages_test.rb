require 'test_helper'

class StaticPagesTest < ActionDispatch::IntegrationTest
describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end
  end
end
  # test "the truth" do
  #   assert true
  # end
end
