# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160204052112) do

  create_table "compra_libros", force: :cascade do |t|
    t.integer  "documento",          limit: 4
    t.string   "serie",              limit: 255
    t.string   "numero",             limit: 255
    t.integer  "dia",                limit: 4
    t.string   "mes",                limit: 255
    t.string   "year",               limit: 255
    t.integer  "proveedor_id",       limit: 4
    t.decimal  "base",                           precision: 10, scale: 2
    t.decimal  "iva",                            precision: 10, scale: 2
    t.decimal  "gravado_bienes",                 precision: 10, scale: 2
    t.decimal  "gravado_servicios",              precision: 10, scale: 2
    t.decimal  "exento_bienes",                  precision: 10, scale: 2
    t.decimal  "exento_servicios",               precision: 10, scale: 2
    t.decimal  "total",                          precision: 10, scale: 2
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.integer  "contribuyente_id",   limit: 4
    t.integer  "establecimiento_id", limit: 4
    t.integer  "tipo_de_gasto_id",   limit: 4
  end

  add_index "compra_libros", ["contribuyente_id"], name: "index_compra_libros_on_contribuyente_id", using: :btree
  add_index "compra_libros", ["establecimiento_id"], name: "index_compra_libros_on_establecimiento_id", using: :btree
  add_index "compra_libros", ["proveedor_id"], name: "index_compra_libros_on_proveedor_id", using: :btree
  add_index "compra_libros", ["tipo_de_gasto_id"], name: "index_compra_libros_on_tipo_de_gasto_id", using: :btree

  create_table "contribuyentes", force: :cascade do |t|
    t.string   "nit",          limit: 255
    t.string   "nombre",       limit: 255
    t.string   "calle",        limit: 255
    t.string   "no_casa",      limit: 255
    t.integer  "zona",         limit: 4
    t.string   "colonia",      limit: 255
    t.string   "departamento", limit: 255
    t.string   "municipio",    limit: 255
    t.string   "telefono",     limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "cuenta_contables", force: :cascade do |t|
    t.decimal  "caja",                                                   precision: 10, scale: 2
    t.decimal  "banco",                                                  precision: 10, scale: 2
    t.decimal  "clientes",                                               precision: 10, scale: 2
    t.decimal  "deudores",                                               precision: 10, scale: 2
    t.decimal  "acciones_suscritas",                                     precision: 10, scale: 2
    t.decimal  "suscriptores_de_acciones",                               precision: 10, scale: 2
    t.decimal  "hipoteca",                                               precision: 10, scale: 2
    t.decimal  "prestamos_fiduciarios",                                  precision: 10, scale: 2
    t.decimal  "documentos_por_cobrar",                                  precision: 10, scale: 2
    t.decimal  "documentos_por_pagar",                                   precision: 10, scale: 2
    t.decimal  "cuentas_por_cobrar",                                     precision: 10, scale: 2
    t.decimal  "cuentas_por_pagar",                                      precision: 10, scale: 2
    t.decimal  "proveedores",                                            precision: 10, scale: 2
    t.decimal  "acreedores",                                             precision: 10, scale: 2
    t.decimal  "inmuebles",                                              precision: 10, scale: 2
    t.decimal  "mobiliario_y_equipo",                                    precision: 10, scale: 2
    t.decimal  "equipo_de_computacion",                                  precision: 10, scale: 2
    t.decimal  "maquinaria",                                             precision: 10, scale: 2
    t.decimal  "herramientas",                                           precision: 10, scale: 2
    t.decimal  "vehiculos",                                              precision: 10, scale: 2
    t.decimal  "cristaleria",                                            precision: 10, scale: 2
    t.decimal  "depreciacion_acumulada_mobiliario_y_equipo",             precision: 10, scale: 2
    t.decimal  "depreciacion_acumulada_equipo_de_computacion",           precision: 10, scale: 2
    t.decimal  "depreciacion_acumulada_maquinaria",                      precision: 10, scale: 2
    t.decimal  "depreciacion_acumulada_herramienta",                     precision: 10, scale: 2
    t.decimal  "depreciacion_acumulada_vehiculos",                       precision: 10, scale: 2
    t.decimal  "depreciacion_acumulada_cristaleria",                     precision: 10, scale: 2
    t.decimal  "capital",                                                precision: 10, scale: 2
    t.decimal  "capital_autorizado",                                     precision: 10, scale: 2
    t.decimal  "reserva_legal",                                          precision: 10, scale: 2
    t.decimal  "ventas",                                                 precision: 10, scale: 2
    t.decimal  "servicios_prestados",                                    precision: 10, scale: 2
    t.decimal  "comisiones_devengadas",                                  precision: 10, scale: 2
    t.decimal  "alquileres_devengados",                                  precision: 10, scale: 2
    t.decimal  "arrendamiento_de_maquinaria",                            precision: 10, scale: 2
    t.decimal  "alquileres_pagados",                                     precision: 10, scale: 2
    t.decimal  "gastos_generales",                                       precision: 10, scale: 2
    t.decimal  "viaticos",                                               precision: 10, scale: 2
    t.decimal  "seguros_pagados",                                        precision: 10, scale: 2
    t.decimal  "servicios_pagados",                                      precision: 10, scale: 2
    t.decimal  "reparacion_y_mantenimiento_gastos",                      precision: 10, scale: 2
    t.decimal  "repuestos_y_accesorios_gastos",                          precision: 10, scale: 2
    t.decimal  "combustibles_y_lubricantes",                             precision: 10, scale: 2
    t.decimal  "costo_por_servicio",                                     precision: 10, scale: 2
    t.decimal  "telefono",                                               precision: 10, scale: 2
    t.decimal  "energia_electrica",                                      precision: 10, scale: 2
    t.decimal  "medicina_y_medicamentos",                                precision: 10, scale: 2
    t.decimal  "depreciacion_mobiliario_y_equipo",                       precision: 10, scale: 2
    t.decimal  "depreciacion_equipo_de_computacion",                     precision: 10, scale: 2
    t.decimal  "depreciacion_maquinaria",                                precision: 10, scale: 2
    t.decimal  "depreciacion_herramienta",                               precision: 10, scale: 2
    t.decimal  "depreciacion_vehiculos",                                 precision: 10, scale: 2
    t.decimal  "depreciacion_cristaleria",                               precision: 10, scale: 2
    t.decimal  "compras",                                                precision: 10, scale: 2
    t.decimal  "intereses_devengados",                                   precision: 10, scale: 2
    t.decimal  "intereses_pagados",                                      precision: 10, scale: 2
    t.decimal  "terrenos",                                               precision: 10, scale: 2
    t.decimal  "edificios",                                              precision: 10, scale: 2
    t.decimal  "gastos_constitucion",                                    precision: 10, scale: 2
    t.decimal  "sueldos_y_salarios",                                     precision: 10, scale: 2
    t.decimal  "retenci¾n_igss_laboral",                                 precision: 10, scale: 2
    t.decimal  "cuota_patronal",                                         precision: 10, scale: 2
    t.decimal  "bonificacion_e_incentivo_laboral",                       precision: 10, scale: 2
    t.decimal  "bono_14",                                                precision: 10, scale: 2
    t.decimal  "aguinaldo",                                              precision: 10, scale: 2
    t.decimal  "fletes_sobre_compras",                                   precision: 10, scale: 2
    t.decimal  "indemnizaciones",                                        precision: 10, scale: 2
    t.decimal  "perdidas_y_ganancias",                                   precision: 10, scale: 2
    t.decimal  "publicidad_y_propaganda",                                precision: 10, scale: 2
    t.decimal  "vacaciones",                                             precision: 10, scale: 2
    t.decimal  "descuentos_sobre_compras",                               precision: 10, scale: 2
    t.decimal  "devoluciones_y_rebajas_sobre_ventas",                    precision: 10, scale: 2
    t.datetime "created_at",                                                                      null: false
    t.datetime "updated_at",                                                                      null: false
    t.integer  "establecimiento_id",                           limit: 4
  end

  add_index "cuenta_contables", ["establecimiento_id"], name: "index_cuenta_contables_on_establecimiento_id", using: :btree

  create_table "establecimientos", force: :cascade do |t|
    t.string   "nombre",           limit: 255
    t.string   "calle",            limit: 255
    t.string   "numero_casa",      limit: 255
    t.integer  "zona",             limit: 4
    t.string   "colonia",          limit: 255
    t.string   "departamento",     limit: 255
    t.string   "municipio",        limit: 255
    t.string   "telefono",         limit: 255
    t.integer  "contribuyente_id", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "establecimientos", ["contribuyente_id"], name: "index_establecimientos_on_contribuyente_id", using: :btree

  create_table "proveedors", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.string   "nit",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "tipo_de_gastos", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "username",               limit: 255
    t.string   "nombre",                 limit: 255
    t.string   "apellido",               limit: 255
    t.integer  "contribuyente_id",       limit: 4
    t.integer  "establecimiento_id",     limit: 4
    t.integer  "mes",                    limit: 4,   default: 0
    t.integer  "year",                   limit: 4,   default: 0
  end

  add_index "usuarios", ["contribuyente_id"], name: "index_usuarios_on_contribuyente_id", using: :btree
  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true, using: :btree
  add_index "usuarios", ["establecimiento_id"], name: "index_usuarios_on_establecimiento_id", using: :btree
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true, using: :btree
  add_index "usuarios", ["username"], name: "index_usuarios_on_username", unique: true, using: :btree

  create_table "venta_libros", force: :cascade do |t|
    t.integer  "documento",          limit: 4
    t.string   "serie",              limit: 255
    t.string   "numero",             limit: 255
    t.integer  "dia",                limit: 4
    t.string   "mes",                limit: 255
    t.string   "year",               limit: 255
    t.string   "nit",                limit: 255
    t.string   "nombre",             limit: 255
    t.decimal  "gravado_bienes",                 precision: 10, scale: 2
    t.decimal  "gravado_servicios",              precision: 10, scale: 2
    t.decimal  "exento_bienes",                  precision: 10, scale: 2
    t.decimal  "exento_servicios",               precision: 10, scale: 2
    t.decimal  "base",                           precision: 10, scale: 2
    t.decimal  "iva",                            precision: 10, scale: 2
    t.decimal  "total",                          precision: 10, scale: 2
    t.integer  "contribuyente_id",   limit: 4
    t.integer  "establecimiento_id", limit: 4
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  add_index "venta_libros", ["contribuyente_id"], name: "index_venta_libros_on_contribuyente_id", using: :btree
  add_index "venta_libros", ["establecimiento_id"], name: "index_venta_libros_on_establecimiento_id", using: :btree

  add_foreign_key "compra_libros", "contribuyentes"
  add_foreign_key "compra_libros", "establecimientos"
  add_foreign_key "compra_libros", "proveedors"
  add_foreign_key "compra_libros", "tipo_de_gastos"
  add_foreign_key "cuenta_contables", "establecimientos"
  add_foreign_key "establecimientos", "contribuyentes"
  add_foreign_key "usuarios", "contribuyentes"
  add_foreign_key "usuarios", "establecimientos"
  add_foreign_key "venta_libros", "contribuyentes"
  add_foreign_key "venta_libros", "establecimientos"
end
