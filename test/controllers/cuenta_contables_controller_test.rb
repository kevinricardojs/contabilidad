require 'test_helper'

class CuentaContablesControllerTest < ActionController::TestCase
  setup do
    @cuenta_contable = cuenta_contables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cuenta_contables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cuenta_contable" do
    assert_difference('CuentaContable.count') do
      post :create, cuenta_contable: { nombre: @cuenta_contable.nombre, tipo: @cuenta_contable.tipo }
    end

    assert_redirected_to cuenta_contable_path(assigns(:cuenta_contable))
  end

  test "should show cuenta_contable" do
    get :show, id: @cuenta_contable
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cuenta_contable
    assert_response :success
  end

  test "should update cuenta_contable" do
    patch :update, id: @cuenta_contable, cuenta_contable: { nombre: @cuenta_contable.nombre, tipo: @cuenta_contable.tipo }
    assert_redirected_to cuenta_contable_path(assigns(:cuenta_contable))
  end

  test "should destroy cuenta_contable" do
    assert_difference('CuentaContable.count', -1) do
      delete :destroy, id: @cuenta_contable
    end

    assert_redirected_to cuenta_contables_path
  end
end
