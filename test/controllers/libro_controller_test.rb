require 'test_helper'

class LibroControllerTest < ActionController::TestCase
  test "should get mayor" do
    get :mayor
    assert_response :success
  end

  test "should get balance" do
    get :balance
    assert_response :success
  end

end
