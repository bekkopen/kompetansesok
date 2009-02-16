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

ActiveRecord::Schema.define(:version => 20090130080044) do

  create_table "fag", :force => true do |t|
    t.string   "uuid"
    t.string   "kode"
    t.text     "tittel"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fag_kompetansemaalsett", :id => false, :force => true do |t|
    t.integer  "fag_id",                :null => false
    t.integer  "kompetansemaalsett_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fag_kompetansemaalsett", ["fag_id"], :name => "index_fag_kompetansemaalsett_on_fag_id"
  add_index "fag_kompetansemaalsett", ["kompetansemaalsett_id"], :name => "index_fag_kompetansemaalsett_on_kompetansemaalsett_id"

  create_table "hovedomraader", :force => true do |t|
    t.string   "uuid"
    t.text     "tittel"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "kode"
  end

  add_index "hovedomraader", ["uuid"], :name => "index_hovedomraader_on_uuid"

  create_table "hovedomraader_kompetansemaal", :id => false, :force => true do |t|
    t.integer  "hovedomraade_id",   :null => false
    t.integer  "kompetansemaal_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hovedomraader_kompetansemaal", ["hovedomraade_id"], :name => "index_hovedomraader_kompetansemaal_on_hovedomraade_id"
  add_index "hovedomraader_kompetansemaal", ["kompetansemaal_id"], :name => "index_hovedomraader_kompetansemaal_on_kompetansemaal_id"

  create_table "hovedomraader_laereplaner", :id => false, :force => true do |t|
    t.integer  "hovedomraade_id", :null => false
    t.integer  "laereplan_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hovedomraader_laereplaner", ["hovedomraade_id"], :name => "index_hovedomraader_laereplaner_on_hovedomraade_id"
  add_index "hovedomraader_laereplaner", ["laereplan_id"], :name => "index_hovedomraader_laereplaner_on_laereplan_id"

  create_table "info", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kompetansemaal", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "tittel"
    t.string   "uuid"
    t.string   "kode"
    t.string   "psi"
  end

  add_index "kompetansemaal", ["uuid"], :name => "index_kompetansemaal_on_uuid"

  create_table "kompetansemaal_kompetansemaalsett", :id => false, :force => true do |t|
    t.integer  "kompetansemaal_id",     :null => false
    t.integer  "kompetansemaalsett_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "kompetansemaal_kompetansemaalsett", ["kompetansemaal_id"], :name => "index_kompetansemaal_kompetansemaalsett_on_kompetansemaal_id"
  add_index "kompetansemaal_kompetansemaalsett", ["kompetansemaalsett_id"], :name => "index_kompetansemaal_kompetansemaalsett_on_kompetansemaalsett_id"

  create_table "kompetansemaalsett", :force => true do |t|
    t.string   "uuid"
    t.text     "tittel"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "kode"
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

  create_table "kompetansemaalsett_trinn", :id => false, :force => true do |t|
    t.integer  "kompetansemaalsett_id", :null => false
    t.integer  "trinn_id",              :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "kompetansemaalsett_trinn", ["kompetansemaalsett_id"], :name => "index_kompetansemaalsett_trinn_on_kompetansemaalsett_id"
  add_index "kompetansemaalsett_trinn", ["trinn_id"], :name => "index_kompetansemaalsett_trinn_on_trinn_id"

  create_table "laereplaner", :force => true do |t|
    t.string   "kode"
    t.text     "tittel"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid"
  end

  add_index "laereplaner", ["uuid"], :name => "index_laereplaner_on_uuid"

  create_table "rdf_md5_sumer", :force => true do |t|
    t.string   "current"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trinn", :force => true do |t|
    t.string   "uuid"
    t.text     "tittel"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
