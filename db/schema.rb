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

ActiveRecord::Schema.define(version: 20150107220329) do

  create_table "personal_details", force: true do |t|
    t.string   "name"
    t.string   "fax"
    t.string   "phone"
    t.string   "picture"
    t.string   "email"
    t.string   "website"
    t.boolean  "sex"
    t.string   "nationality"
    t.date     "dob"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "resume_id"
    t.string   "address1"
    t.string   "address2"
    t.string   "address3"
  end

  add_index "personal_details", ["resume_id"], name: "index_personal_details_on_resume_id"

  create_table "resumes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "template"
  end

  create_table "simplelistitems", force: true do |t|
    t.string   "content"
    t.integer  "simplelist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order"
  end

  add_index "simplelistitems", ["simplelist_id"], name: "index_simplelistitems_on_simplelist_id"

  create_table "simplelists", force: true do |t|
    t.string   "name"
    t.integer  "resume_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order"
    t.boolean  "ordered_list"
  end

  add_index "simplelists", ["resume_id"], name: "index_simplelists_on_resume_id"

  create_table "textsections", force: true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "resume_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order"
  end

  add_index "textsections", ["resume_id"], name: "index_textsections_on_resume_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

  create_table "worklist_items", force: true do |t|
    t.string   "line1"
    t.string   "line2"
    t.text     "desc"
    t.date     "start"
    t.date     "end"
    t.integer  "worklist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order"
  end

  add_index "worklist_items", ["worklist_id"], name: "index_worklist_items_on_worklist_id"

  create_table "worklists", force: true do |t|
    t.string   "name"
    t.integer  "order"
    t.integer  "resume_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "worklists", ["resume_id"], name: "index_worklists_on_resume_id"

end
