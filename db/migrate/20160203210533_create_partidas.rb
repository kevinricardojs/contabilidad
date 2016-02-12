class CreatePartidas < ActiveRecord::Migration
  def change
    create_table :partidas do |t|
      t.decimal :caja, precision: 10, scale: 2
      t.decimal :banco, precision: 10, scale: 2
      t.decimal :clientes, precision: 10, scale: 2
      t.decimal :deudores, precision: 10, scale: 2
      t.decimal :acciones_suscritas, precision: 10, scale: 2
      t.decimal :suscriptores_de_acciones, precision: 10, scale: 2
      t.decimal :hipoteca, precision: 10, scale: 2
      t.decimal :prestamos_fiduciarios, precision: 10, scale: 2
      t.decimal :documentos_por_cobrar, precision: 10, scale: 2
      t.decimal :documentos_por_pagar, precision: 10, scale: 2
      t.decimal :cuentas_por_cobrar, precision: 10, scale: 2
      t.decimal :cuentas_por_pagar, precision: 10, scale: 2
      t.decimal :proveedores, precision: 10, scale: 2
      t.decimal :acreedores, precision: 10, scale: 2
      t.decimal :inmuebles, precision: 10, scale: 2
      t.decimal :mobiliario_y_equipo, precision: 10, scale: 2
      t.decimal :equipo_de_computacion, precision: 10, scale: 2
      t.decimal :maquinaria, precision: 10, scale: 2
      t.decimal :herramientas, precision: 10, scale: 2
      t.decimal :vehiculos, precision: 10, scale: 2
      t.decimal :cristaleria, precision: 10, scale: 2
      t.decimal :depreciacion_acumulada_mobiliario_y_equipo, precision: 10, scale: 2
      t.decimal :depreciacion_acumulada_equipo_de_computacion, precision: 10, scale: 2
      t.decimal :depreciacion_acumulada_maquinaria, precision: 10, scale: 2
      t.decimal :depreciacion_acumulada_herramienta, precision: 10, scale: 2
      t.decimal :depreciacion_acumulada_vehiculos, precision: 10, scale: 2
      t.decimal :depreciacion_acumulada_cristaleria, precision: 10, scale: 2
      t.decimal :capital, precision: 10, scale: 2
      t.decimal :capital_autorizado, precision: 10, scale: 2
      t.decimal :reserva_legal, precision: 10, scale: 2
      t.decimal :ventas, precision: 10, scale: 2
      t.decimal :servicios_prestados, precision: 10, scale: 2
      t.decimal :comisiones_devengadas, precision: 10, scale: 2
      t.decimal :alquileres_devengados, precision: 10, scale: 2
      t.decimal :arrendamiento_de_maquinaria, precision: 10, scale: 2
      t.decimal :alquileres_pagados, precision: 10, scale: 2
      t.decimal :gastos_generales, precision: 10, scale: 2
      t.decimal :viaticos, precision: 10, scale: 2
      t.decimal :seguros_pagados, precision: 10, scale: 2
      t.decimal :servicios_pagados, precision: 10, scale: 2
      t.decimal :reparacion_y_mantenimiento_gastos, precision: 10, scale: 2
      t.decimal :repuestos_y_accesorios_gastos, precision: 10, scale: 2
      t.decimal :combustibles_y_lubricantes, precision: 10, scale: 2
      t.decimal :costo_por_servicio, precision: 10, scale: 2
      t.decimal :telefono, precision: 10, scale: 2
      t.decimal :energia_electrica, precision: 10, scale: 2
      t.decimal :medicina_y_medicamentos, precision: 10, scale: 2
      t.decimal :depreciacion_mobiliario_y_equipo, precision: 10, scale: 2
      t.decimal :depreciacion_equipo_de_computacion, precision: 10, scale: 2
      t.decimal :depreciacion_maquinaria, precision: 10, scale: 2
      t.decimal :depreciacion_herramienta, precision: 10, scale: 2
      t.decimal :depreciacion_vehiculos, precision: 10, scale: 2
      t.decimal :depreciacion_cristaleria, precision: 10, scale: 2
      t.decimal :compras, precision: 10, scale: 2
      t.decimal :intereses_devengados, precision: 10, scale: 2
      t.decimal :intereses_pagados, precision: 10, scale: 2
      t.decimal :terrenos, precision: 10, scale: 2
      t.decimal :edificios, precision: 10, scale: 2
      t.decimal :gastos_constitucion, precision: 10, scale: 2
      t.decimal :sueldos_y_salarios, precision: 10, scale: 2
      t.decimal :retenci¾n_igss_laboral, precision: 10, scale: 2
      t.decimal :cuota_patronal, precision: 10, scale: 2
      t.decimal :bonificacion_e_incentivo_laboral, precision: 10, scale: 2
      t.decimal :bono_14, precision: 10, scale: 2
      t.decimal :aguinaldo, precision: 10, scale: 2
      t.decimal :fletes_sobre_compras, precision: 10, scale: 2
      t.decimal :indemnizaciones, precision: 10, scale: 2
      t.decimal :perdidas_y_ganancias, precision: 10, scale: 2
      t.decimal :publicidad_y_propaganda, precision: 10, scale: 2
      t.decimal :vacaciones, precision: 10, scale: 2
      t.decimal :descuentos_sobre_compras, precision: 10, scale: 2
      t.decimal :devoluciones_y_rebajas_sobre_ventas, precision: 10, scale: 2

      t.timestamps null: false
    end
  end
end
