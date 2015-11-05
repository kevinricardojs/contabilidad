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

ActiveRecord::Schema.define(version: 20151105161449) do

  create_table "contribuyentes", force: :cascade do |t|
    t.string   "nit",          limit: 255
    t.string   "nombre",       limit: 255
    t.string   "calle",        limit: 255
    t.string   "no_casa",      limit: 255
    t.string   "apto_similar", limit: 255
    t.integer  "zona",         limit: 4
    t.string   "colonia",      limit: 255
    t.string   "departamento", limit: 255
    t.string   "municipio",    limit: 255
    t.string   "telefono",     limit: 255
    t.string   "fax",          limit: 255
    t.string   "apto_postal",  limit: 255
    t.string   "email",        limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

end
