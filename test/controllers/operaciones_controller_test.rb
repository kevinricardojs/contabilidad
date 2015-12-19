require 'test_helper'

class OperacionesControllerTest < ActionController::TestCase
  test "should get reporte_del_mes" do
    get :reporte_del_mes
    assert_response :success
  end

end
