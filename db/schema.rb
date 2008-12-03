# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081203165028) do

  create_table "kompetansemaalsett", :force => true do |t|
    t.string   "uuid"
    t.string   "tittel"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "kompetansemaalsett", ["uuid"], :name => "index_kompetansemaalsett_on_uuid"

  create_table "kompetansemaalsett_laereplaner", :id => false, :force => true do |t|
    t.integer  "kompetansemaalsett_id", :null => false
    t.integer  "laereplan_id",          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "kompetansemaalsett_laereplaner", ["kompetansemaalsett_id"], :name => "index_kompetansemaalsett_laereplaner_on_kompetansemaalsett_id"
  add_index "kompetansemaalsett_laereplaner", ["laereplan_id"], :name => "index_kompetansemaalsett_laereplaner_on_laereplan_id"

  create_table "laereplaner", :force => true do |t|
    t.string   "kode"
    t.string   "tittel"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid"
  end

end
