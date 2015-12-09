require 'test_helper'

class CompraLibrosControllerTest < ActionController::TestCase
  setup do
    @compra_libro = compra_libros(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:compra_libros)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create compra_libro" do
    assert_difference('CompraLibro.count') do
      post :create, compra_libro: { dia: @compra_libro.dia, documento: @compra_libro.documento, mes: @compra_libro.mes, numero: @compra_libro.numero, proveedor_id: @compra_libro.proveedor_id, serie: @compra_libro.serie, year: @compra_libro.year }
    end

    assert_redirected_to compra_libro_path(assigns(:compra_libro))
  end

  test "should show compra_libro" do
    get :show, id: @compra_libro
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @compra_libro
    assert_response :success
  end

  test "should update compra_libro" do
    patch :update, id: @compra_libro, compra_libro: { dia: @compra_libro.dia, documento: @compra_libro.documento, mes: @compra_libro.mes, numero: @compra_libro.numero, proveedor_id: @compra_libro.proveedor_id, serie: @compra_libro.serie, year: @compra_libro.year }
    assert_redirected_to compra_libro_path(assigns(:compra_libro))
  end

  test "should destroy compra_libro" do
    assert_difference('CompraLibro.count', -1) do
      delete :destroy, id: @compra_libro
    end

    assert_redirected_to compra_libros_path
  end
end
