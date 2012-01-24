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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111025132553) do

  create_table "customers", :force => true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "company"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "newsly_newsletters", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "sent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "batch_sent"
    t.text     "internal_template"
  end

  create_table "newsly_templates", :force => true do |t|
    t.string   "name"
    t.string   "template_type"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "draft"
    t.integer  "parent_id"
    t.string   "friendly_name"
    t.string   "description"
    t.text     "internal_template"
  end

end
