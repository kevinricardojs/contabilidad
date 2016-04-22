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

ActiveRecord::Schema.define(version: 20160422201618) do

  create_table "balances", force: :cascade do |t|
    t.integer  "establecimiento_id", limit: 4
    t.integer  "year",               limit: 4
    t.integer  "periodo",            limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "balances", ["establecimiento_id"], name: "index_balances_on_establecimiento_id", using: :btree

  create_table "compra_libros", force: :cascade do |t|
    t.integer  "documento",          limit: 4
    t.string   "serie",              limit: 255
    t.integer  "numero",             limit: 4
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
    t.string   "dato_mes",           limit: 255
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

  create_table "cuentas", force: :cascade do |t|
    t.string   "nombre",          limit: 255
    t.string   "nombre_",         limit: 255
    t.string   "debe",            limit: 255
    t.string   "haber",           limit: 255
    t.integer  "partida_id",      limit: 4
    t.integer  "posicion",        limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "libro_diario_id", limit: 4
    t.integer  "balance_id",      limit: 4
  end

  add_index "cuentas", ["balance_id"], name: "index_cuentas_on_balance_id", using: :btree
  add_index "cuentas", ["libro_diario_id"], name: "index_cuentas_on_libro_diario_id", using: :btree
  add_index "cuentas", ["partida_id"], name: "index_cuentas_on_partida_id", using: :btree

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

  create_table "folios", force: :cascade do |t|
    t.string   "libro",              limit: 255
    t.integer  "paginas",            limit: 4
    t.string   "year",               limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "establecimiento_id", limit: 4
  end

  add_index "folios", ["establecimiento_id"], name: "index_folios_on_establecimiento_id", using: :btree

  create_table "libro_diarios", force: :cascade do |t|
    t.integer  "establecimiento_id", limit: 4
    t.string   "mes",                limit: 255
    t.string   "year",               limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "periodo",            limit: 4
    t.integer  "balance_id",         limit: 4
  end

  add_index "libro_diarios", ["balance_id"], name: "index_libro_diarios_on_balance_id", using: :btree
  add_index "libro_diarios", ["establecimiento_id"], name: "index_libro_diarios_on_establecimiento_id", using: :btree

  create_table "partidas", force: :cascade do |t|
    t.string   "dia",                limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "establecimiento_id", limit: 4
    t.integer  "libro_diario_id",    limit: 4
    t.string   "descripcion",        limit: 255
    t.integer  "numero_partida",     limit: 4
  end

  add_index "partidas", ["establecimiento_id"], name: "index_partidas_on_establecimiento_id", using: :btree
  add_index "partidas", ["libro_diario_id"], name: "index_partidas_on_libro_diario_id", using: :btree

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
    t.integer  "numero",             limit: 4
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

  add_foreign_key "balances", "establecimientos"
  add_foreign_key "compra_libros", "contribuyentes"
  add_foreign_key "compra_libros", "establecimientos"
  add_foreign_key "compra_libros", "proveedors"
  add_foreign_key "compra_libros", "tipo_de_gastos"
  add_foreign_key "cuentas", "balances"
  add_foreign_key "cuentas", "libro_diarios"
  add_foreign_key "cuentas", "partidas"
  add_foreign_key "establecimientos", "contribuyentes"
  add_foreign_key "folios", "establecimientos"
  add_foreign_key "libro_diarios", "balances"
  add_foreign_key "libro_diarios", "establecimientos"
  add_foreign_key "partidas", "establecimientos"
  add_foreign_key "partidas", "libro_diarios"
  add_foreign_key "usuarios", "contribuyentes"
  add_foreign_key "usuarios", "establecimientos"
  add_foreign_key "venta_libros", "contribuyentes"
  add_foreign_key "venta_libros", "establecimientos"
end
