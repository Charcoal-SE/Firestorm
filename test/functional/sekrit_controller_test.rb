require 'test_helper'

class SekritControllerTest < ActionController::TestCase
  test "should get yay" do
    get :yay
    assert_response :success
  end

end
