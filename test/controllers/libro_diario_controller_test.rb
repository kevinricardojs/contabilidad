require 'test_helper'

class LibroDiarioControllerTest < ActionController::TestCase
  test "should get partidas" do
    get :partidas
    assert_response :success
  end

  test "should get resumen" do
    get :resumen
    assert_response :success
  end

end
