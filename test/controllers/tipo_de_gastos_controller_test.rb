require 'test_helper'

class TipoDeGastosControllerTest < ActionController::TestCase
  setup do
    @tipo_de_gasto = tipo_de_gastos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipo_de_gastos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_de_gasto" do
    assert_difference('TipoDeGasto.count') do
      post :create, tipo_de_gasto: { nombre: @tipo_de_gasto.nombre }
    end

    assert_redirected_to tipo_de_gasto_path(assigns(:tipo_de_gasto))
  end

  test "should show tipo_de_gasto" do
    get :show, id: @tipo_de_gasto
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tipo_de_gasto
    assert_response :success
  end

  test "should update tipo_de_gasto" do
    patch :update, id: @tipo_de_gasto, tipo_de_gasto: { nombre: @tipo_de_gasto.nombre }
    assert_redirected_to tipo_de_gasto_path(assigns(:tipo_de_gasto))
  end

  test "should destroy tipo_de_gasto" do
    assert_difference('TipoDeGasto.count', -1) do
      delete :destroy, id: @tipo_de_gasto
    end

    assert_redirected_to tipo_de_gastos_path
  end
end
