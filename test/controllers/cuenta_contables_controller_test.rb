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
      post :create, cuenta_contable: { acciones_suscritas: @cuenta_contable.acciones_suscritas, acreedores: @cuenta_contable.acreedores, aguinaldo: @cuenta_contable.aguinaldo, alquileres_devengados: @cuenta_contable.alquileres_devengados, alquileres_pagados: @cuenta_contable.alquileres_pagados, arrendamiento_de_maquinaria: @cuenta_contable.arrendamiento_de_maquinaria, banco: @cuenta_contable.banco, bonificacion_e_incentivo_laboral: @cuenta_contable.bonificacion_e_incentivo_laboral, bono_14: @cuenta_contable.bono_14, caja: @cuenta_contable.caja, capital: @cuenta_contable.capital, capital_autorizado: @cuenta_contable.capital_autorizado, clientes: @cuenta_contable.clientes, combustibles_y_lubricantes: @cuenta_contable.combustibles_y_lubricantes, comisiones_devengadas: @cuenta_contable.comisiones_devengadas, compras: @cuenta_contable.compras, costo_por_servicio: @cuenta_contable.costo_por_servicio, cristaleria: @cuenta_contable.cristaleria, cuentas_por_cobrar: @cuenta_contable.cuentas_por_cobrar, cuentas_por_pagar: @cuenta_contable.cuentas_por_pagar, cuota_patronal: @cuenta_contable.cuota_patronal, depreciacion_acumulada_cristaleria: @cuenta_contable.depreciacion_acumulada_cristaleria, depreciacion_acumulada_equipo_de_computacion: @cuenta_contable.depreciacion_acumulada_equipo_de_computacion, depreciacion_acumulada_herramienta: @cuenta_contable.depreciacion_acumulada_herramienta, depreciacion_acumulada_maquinaria: @cuenta_contable.depreciacion_acumulada_maquinaria, depreciacion_acumulada_mobiliario_y_equipo: @cuenta_contable.depreciacion_acumulada_mobiliario_y_equipo, depreciacion_acumulada_vehiculos: @cuenta_contable.depreciacion_acumulada_vehiculos, depreciacion_cristaleria: @cuenta_contable.depreciacion_cristaleria, depreciacion_equipo_de_computacion: @cuenta_contable.depreciacion_equipo_de_computacion, depreciacion_herramienta: @cuenta_contable.depreciacion_herramienta, depreciacion_maquinaria: @cuenta_contable.depreciacion_maquinaria, depreciacion_mobiliario_y_equipo: @cuenta_contable.depreciacion_mobiliario_y_equipo, depreciacion_vehiculos: @cuenta_contable.depreciacion_vehiculos, descuentos_sobre_compras: @cuenta_contable.descuentos_sobre_compras, deudores: @cuenta_contable.deudores, devoluciones_y_rebajas_sobre_ventas: @cuenta_contable.devoluciones_y_rebajas_sobre_ventas, documentos_por_cobrar: @cuenta_contable.documentos_por_cobrar, documentos_por_pagar: @cuenta_contable.documentos_por_pagar, edificios: @cuenta_contable.edificios, energia_electrica: @cuenta_contable.energia_electrica, equipo_de_computacion: @cuenta_contable.equipo_de_computacion, fletes_sobre_compras: @cuenta_contable.fletes_sobre_compras, gastos_constitucion: @cuenta_contable.gastos_constitucion, gastos_generales: @cuenta_contable.gastos_generales, herramientas: @cuenta_contable.herramientas, hipoteca: @cuenta_contable.hipoteca, indemnizaciones: @cuenta_contable.indemnizaciones, inmuebles: @cuenta_contable.inmuebles, intereses_devengados: @cuenta_contable.intereses_devengados, intereses_pagados: @cuenta_contable.intereses_pagados, maquinaria: @cuenta_contable.maquinaria, medicina_y_medicamentos: @cuenta_contable.medicina_y_medicamentos, mobiliario_y_equipo: @cuenta_contable.mobiliario_y_equipo, perdidas_y_ganancias: @cuenta_contable.perdidas_y_ganancias, prestamos_fiduciarios: @cuenta_contable.prestamos_fiduciarios, proveedores: @cuenta_contable.proveedores, publicidad_y_propaganda: @cuenta_contable.publicidad_y_propaganda, reparacion_y_mantenimiento_gastos: @cuenta_contable.reparacion_y_mantenimiento_gastos, repuestos_y_accesorios_gastos: @cuenta_contable.repuestos_y_accesorios_gastos, reserva_legal: @cuenta_contable.reserva_legal, retenci¾n_igss_laboral: @cuenta_contable.retenci¾n_igss_laboral, seguros_pagados: @cuenta_contable.seguros_pagados, servicios_pagados: @cuenta_contable.servicios_pagados, servicios_prestados: @cuenta_contable.servicios_prestados, sueldos_y_salarios: @cuenta_contable.sueldos_y_salarios, suscriptores_de_acciones: @cuenta_contable.suscriptores_de_acciones, telefono: @cuenta_contable.telefono, terrenos: @cuenta_contable.terrenos, vacaciones: @cuenta_contable.vacaciones, vehiculos: @cuenta_contable.vehiculos, ventas: @cuenta_contable.ventas, viaticos: @cuenta_contable.viaticos }
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
    patch :update, id: @cuenta_contable, cuenta_contable: { acciones_suscritas: @cuenta_contable.acciones_suscritas, acreedores: @cuenta_contable.acreedores, aguinaldo: @cuenta_contable.aguinaldo, alquileres_devengados: @cuenta_contable.alquileres_devengados, alquileres_pagados: @cuenta_contable.alquileres_pagados, arrendamiento_de_maquinaria: @cuenta_contable.arrendamiento_de_maquinaria, banco: @cuenta_contable.banco, bonificacion_e_incentivo_laboral: @cuenta_contable.bonificacion_e_incentivo_laboral, bono_14: @cuenta_contable.bono_14, caja: @cuenta_contable.caja, capital: @cuenta_contable.capital, capital_autorizado: @cuenta_contable.capital_autorizado, clientes: @cuenta_contable.clientes, combustibles_y_lubricantes: @cuenta_contable.combustibles_y_lubricantes, comisiones_devengadas: @cuenta_contable.comisiones_devengadas, compras: @cuenta_contable.compras, costo_por_servicio: @cuenta_contable.costo_por_servicio, cristaleria: @cuenta_contable.cristaleria, cuentas_por_cobrar: @cuenta_contable.cuentas_por_cobrar, cuentas_por_pagar: @cuenta_contable.cuentas_por_pagar, cuota_patronal: @cuenta_contable.cuota_patronal, depreciacion_acumulada_cristaleria: @cuenta_contable.depreciacion_acumulada_cristaleria, depreciacion_acumulada_equipo_de_computacion: @cuenta_contable.depreciacion_acumulada_equipo_de_computacion, depreciacion_acumulada_herramienta: @cuenta_contable.depreciacion_acumulada_herramienta, depreciacion_acumulada_maquinaria: @cuenta_contable.depreciacion_acumulada_maquinaria, depreciacion_acumulada_mobiliario_y_equipo: @cuenta_contable.depreciacion_acumulada_mobiliario_y_equipo, depreciacion_acumulada_vehiculos: @cuenta_contable.depreciacion_acumulada_vehiculos, depreciacion_cristaleria: @cuenta_contable.depreciacion_cristaleria, depreciacion_equipo_de_computacion: @cuenta_contable.depreciacion_equipo_de_computacion, depreciacion_herramienta: @cuenta_contable.depreciacion_herramienta, depreciacion_maquinaria: @cuenta_contable.depreciacion_maquinaria, depreciacion_mobiliario_y_equipo: @cuenta_contable.depreciacion_mobiliario_y_equipo, depreciacion_vehiculos: @cuenta_contable.depreciacion_vehiculos, descuentos_sobre_compras: @cuenta_contable.descuentos_sobre_compras, deudores: @cuenta_contable.deudores, devoluciones_y_rebajas_sobre_ventas: @cuenta_contable.devoluciones_y_rebajas_sobre_ventas, documentos_por_cobrar: @cuenta_contable.documentos_por_cobrar, documentos_por_pagar: @cuenta_contable.documentos_por_pagar, edificios: @cuenta_contable.edificios, energia_electrica: @cuenta_contable.energia_electrica, equipo_de_computacion: @cuenta_contable.equipo_de_computacion, fletes_sobre_compras: @cuenta_contable.fletes_sobre_compras, gastos_constitucion: @cuenta_contable.gastos_constitucion, gastos_generales: @cuenta_contable.gastos_generales, herramientas: @cuenta_contable.herramientas, hipoteca: @cuenta_contable.hipoteca, indemnizaciones: @cuenta_contable.indemnizaciones, inmuebles: @cuenta_contable.inmuebles, intereses_devengados: @cuenta_contable.intereses_devengados, intereses_pagados: @cuenta_contable.intereses_pagados, maquinaria: @cuenta_contable.maquinaria, medicina_y_medicamentos: @cuenta_contable.medicina_y_medicamentos, mobiliario_y_equipo: @cuenta_contable.mobiliario_y_equipo, perdidas_y_ganancias: @cuenta_contable.perdidas_y_ganancias, prestamos_fiduciarios: @cuenta_contable.prestamos_fiduciarios, proveedores: @cuenta_contable.proveedores, publicidad_y_propaganda: @cuenta_contable.publicidad_y_propaganda, reparacion_y_mantenimiento_gastos: @cuenta_contable.reparacion_y_mantenimiento_gastos, repuestos_y_accesorios_gastos: @cuenta_contable.repuestos_y_accesorios_gastos, reserva_legal: @cuenta_contable.reserva_legal, retenci¾n_igss_laboral: @cuenta_contable.retenci¾n_igss_laboral, seguros_pagados: @cuenta_contable.seguros_pagados, servicios_pagados: @cuenta_contable.servicios_pagados, servicios_prestados: @cuenta_contable.servicios_prestados, sueldos_y_salarios: @cuenta_contable.sueldos_y_salarios, suscriptores_de_acciones: @cuenta_contable.suscriptores_de_acciones, telefono: @cuenta_contable.telefono, terrenos: @cuenta_contable.terrenos, vacaciones: @cuenta_contable.vacaciones, vehiculos: @cuenta_contable.vehiculos, ventas: @cuenta_contable.ventas, viaticos: @cuenta_contable.viaticos }
    assert_redirected_to cuenta_contable_path(assigns(:cuenta_contable))
  end

  test "should destroy cuenta_contable" do
    assert_difference('CuentaContable.count', -1) do
      delete :destroy, id: @cuenta_contable
    end

    assert_redirected_to cuenta_contables_path
  end
end
