require 'test_helper'

class OperacionControllerTest < ActionController::TestCase
  test "should get seleccion" do
    get :seleccion
    assert_response :success
  end

end
