require 'test_helper'

class ContribuyentesControllerTest < ActionController::TestCase
  setup do
    @contribuyente = contribuyentes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contribuyentes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contribuyente" do
    assert_difference('Contribuyente.count') do
      post :create, contribuyente: { apto_postal: @contribuyente.apto_postal, apto_similar: @contribuyente.apto_similar, calle: @contribuyente.calle, colonia: @contribuyente.colonia, departamento: @contribuyente.departamento, email: @contribuyente.email, fax: @contribuyente.fax, municipio: @contribuyente.municipio, nit: @contribuyente.nit, no_casa: @contribuyente.no_casa, nombre: @contribuyente.nombre, telefono: @contribuyente.telefono, zona: @contribuyente.zona }
    end

    assert_redirected_to contribuyente_path(assigns(:contribuyente))
  end

  test "should show contribuyente" do
    get :show, id: @contribuyente
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contribuyente
    assert_response :success
  end

  test "should update contribuyente" do
    patch :update, id: @contribuyente, contribuyente: { apto_postal: @contribuyente.apto_postal, apto_similar: @contribuyente.apto_similar, calle: @contribuyente.calle, colonia: @contribuyente.colonia, departamento: @contribuyente.departamento, email: @contribuyente.email, fax: @contribuyente.fax, municipio: @contribuyente.municipio, nit: @contribuyente.nit, no_casa: @contribuyente.no_casa, nombre: @contribuyente.nombre, telefono: @contribuyente.telefono, zona: @contribuyente.zona }
    assert_redirected_to contribuyente_path(assigns(:contribuyente))
  end

  test "should destroy contribuyente" do
    assert_difference('Contribuyente.count', -1) do
      delete :destroy, id: @contribuyente
    end

    assert_redirected_to contribuyentes_path
  end
end
