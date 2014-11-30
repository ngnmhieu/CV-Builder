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

ActiveRecord::Schema.define(version: 20141129230055) do

  create_table "cvs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "personal_details", force: true do |t|
    t.string   "name"
    t.string   "fax"
    t.string   "phone"
    t.string   "address"
    t.string   "picture"
    t.string   "email"
    t.string   "website"
    t.boolean  "sex"
    t.string   "nationality"
    t.date     "dob"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cv_id"
  end

  add_index "personal_details", ["cv_id"], name: "index_personal_details_on_cv_id"

end
