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

ActiveRecord::Schema.define(version: 20151210154124) do

  create_table "compra_libros", force: :cascade do |t|
    t.integer  "documento",          limit: 4
    t.string   "serie",              limit: 255
    t.string   "numero",             limit: 255
    t.integer  "dia",                limit: 4
    t.string   "mes",                limit: 255
    t.string   "year",               limit: 255
    t.integer  "proveedor_id",       limit: 4
    t.string   "base",               limit: 255
    t.string   "iva",                limit: 255
    t.string   "gravado_bienes",     limit: 255
    t.string   "gravado_servicios",  limit: 255
    t.string   "exento_bienes",      limit: 255
    t.string   "exento_servicios",   limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "contribuyente_id",   limit: 4
    t.integer  "establecimiento_id", limit: 4
    t.integer  "cuenta_contable_id", limit: 4
    t.string   "total",              limit: 255
  end

  add_index "compra_libros", ["contribuyente_id"], name: "index_compra_libros_on_contribuyente_id", using: :btree
  add_index "compra_libros", ["cuenta_contable_id"], name: "index_compra_libros_on_cuenta_contable_id", using: :btree
  add_index "compra_libros", ["establecimiento_id"], name: "index_compra_libros_on_establecimiento_id", using: :btree
  add_index "compra_libros", ["proveedor_id"], name: "index_compra_libros_on_proveedor_id", using: :btree

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
    t.string   "nombre",     limit: 255
    t.integer  "tipo",       limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

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
    t.string   "gravado_bienes",     limit: 255
    t.string   "gravado_servicios",  limit: 255
    t.string   "exento_bienes",      limit: 255
    t.string   "exento_servicios",   limit: 255
    t.string   "base",               limit: 255
    t.string   "iva",                limit: 255
    t.string   "total",              limit: 255
    t.integer  "contribuyente_id",   limit: 4
    t.integer  "establecimiento_id", limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "venta_libros", ["contribuyente_id"], name: "index_venta_libros_on_contribuyente_id", using: :btree
  add_index "venta_libros", ["establecimiento_id"], name: "index_venta_libros_on_establecimiento_id", using: :btree

  add_foreign_key "compra_libros", "contribuyentes"
  add_foreign_key "compra_libros", "cuenta_contables"
  add_foreign_key "compra_libros", "establecimientos"
  add_foreign_key "compra_libros", "proveedors"
  add_foreign_key "establecimientos", "contribuyentes"
  add_foreign_key "usuarios", "contribuyentes"
  add_foreign_key "usuarios", "establecimientos"
  add_foreign_key "venta_libros", "contribuyentes"
  add_foreign_key "venta_libros", "establecimientos"
end
