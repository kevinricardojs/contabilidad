require 'test_helper'

class VentaLibrosControllerTest < ActionController::TestCase
  setup do
    @venta_libro = venta_libros(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:venta_libros)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create venta_libro" do
    assert_difference('VentaLibro.count') do
      post :create, venta_libro: { base: @venta_libro.base, contribuyente_id: @venta_libro.contribuyente_id, dia: @venta_libro.dia, documento: @venta_libro.documento, establecimiento_id: @venta_libro.establecimiento_id, exento_bienes: @venta_libro.exento_bienes, exento_servicios: @venta_libro.exento_servicios, gravado_bienes: @venta_libro.gravado_bienes, gravado_servicios: @venta_libro.gravado_servicios, iva: @venta_libro.iva, mes: @venta_libro.mes, nit: @venta_libro.nit, nombre: @venta_libro.nombre, numero: @venta_libro.numero, serie: @venta_libro.serie, total: @venta_libro.total, year: @venta_libro.year }
    end

    assert_redirected_to venta_libro_path(assigns(:venta_libro))
  end

  test "should show venta_libro" do
    get :show, id: @venta_libro
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @venta_libro
    assert_response :success
  end

  test "should update venta_libro" do
    patch :update, id: @venta_libro, venta_libro: { base: @venta_libro.base, contribuyente_id: @venta_libro.contribuyente_id, dia: @venta_libro.dia, documento: @venta_libro.documento, establecimiento_id: @venta_libro.establecimiento_id, exento_bienes: @venta_libro.exento_bienes, exento_servicios: @venta_libro.exento_servicios, gravado_bienes: @venta_libro.gravado_bienes, gravado_servicios: @venta_libro.gravado_servicios, iva: @venta_libro.iva, mes: @venta_libro.mes, nit: @venta_libro.nit, nombre: @venta_libro.nombre, numero: @venta_libro.numero, serie: @venta_libro.serie, total: @venta_libro.total, year: @venta_libro.year }
    assert_redirected_to venta_libro_path(assigns(:venta_libro))
  end

  test "should destroy venta_libro" do
    assert_difference('VentaLibro.count', -1) do
      delete :destroy, id: @venta_libro
    end

    assert_redirected_to venta_libros_path
  end
end
