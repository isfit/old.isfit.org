require 'test_helper'

class DonationsControllerTest < ActionController::TestCase
  test "should get donate" do
    get :donate
    assert_response :success
  end

  test "should get thank_you" do
    get :thank_you
    assert_response :success
  end

end
