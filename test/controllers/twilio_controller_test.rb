require 'test_helper'

class TwilioControllerTest < ActionController::TestCase
  test "should get parse_message" do
    get :parse_message
    assert_response :success
  end

end
