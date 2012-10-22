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

ActiveRecord::Schema.define(:version => 20120813183646) do

  create_table "alumni_reservations", :force => true do |t|
    t.string   "firstname"
    t.string   "surname"
    t.integer  "isfit_year"
    t.integer  "phone"
    t.boolean  "restaurant"
    t.boolean  "peaceprize_ceremony"
    t.boolean  "hybel_friday"
    t.boolean  "hybel_saturday"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mail"
  end

  create_table "ambassadors", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "zip_code"
    t.string   "email"
    t.string   "city"
    t.integer  "country_id"
    t.integer  "infopackage_contact_type_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "ambassadors", ["country_id"], :name => "index_ambassadors_on_country_id"

  create_table "answers", :force => true do |t|
    t.integer "attend",               :limit => 1,                          :null => false
    t.string  "visa",                 :limit => 0,                          :null => false
    t.string  "stay_with",            :limit => 0, :default => "NO_MATTER", :null => false
    t.integer "smoke",                :limit => 1, :default => 0,           :null => false
    t.integer "handicap",             :limit => 1, :default => 0,           :null => false
    t.text    "handicap_description"
    t.text    "food_description"
    t.integer "no_special",           :limit => 1
    t.integer "vegetarian",           :limit => 1
    t.integer "lactose",              :limit => 1
    t.integer "gluten",               :limit => 1
    t.integer "kosher",               :limit => 1
    t.integer "halal",                :limit => 1
    t.integer "other",                :limit => 1
  end

  create_table "applicants", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "mail"
    t.integer  "phone"
    t.text     "information"
    t.text     "background"
    t.text     "heardof"
    t.integer  "position_id_1",                                        :null => false
    t.integer  "position_id_2"
    t.integer  "position_id_3"
    t.integer  "status",                            :default => 0
    t.text     "comment"
    t.string   "interview_place_1"
    t.string   "interview_place_2"
    t.string   "interview_place_3"
    t.datetime "interview_time_1"
    t.datetime "interview_time_2"
    t.datetime "interview_time_3"
    t.integer  "interviewer_id_1_1"
    t.integer  "interviewer_id_1_2"
    t.integer  "interviewer_id_2_1"
    t.integer  "interviewer_id_2_2"
    t.integer  "interviewer_id_3_1"
    t.integer  "interviewer_id_3_2"
    t.boolean  "deleted",                           :default => false, :null => false
    t.string   "username"
    t.string   "password",           :limit => 16
    t.string   "dn",                 :limit => 512
    t.integer  "has_account",        :limit => 1,   :default => 0,     :null => false
    t.integer  "is_notified",                       :default => 0,     :null => false
  end

  create_table "articles", :force => true do |t|
    t.string   "title_en"
    t.string   "title_no"
    t.text     "ingress_en"
    t.text     "ingress_no"
    t.text     "body_en"
    t.text     "body_no"
    t.boolean  "list"
    t.integer  "weight"
    t.datetime "created_at"
    t.boolean  "deleted"
    t.integer  "press_release",                       :limit => 1
    t.string   "sub_title_no"
    t.string   "sub_title_en"
    t.string   "image_text_no"
    t.string   "image_text_en"
    t.boolean  "main_article"
    t.boolean  "published"
    t.string   "byline"
    t.integer  "byline_user_id"
    t.string   "image_credits"
    t.integer  "mail_sent"
    t.datetime "show_article"
    t.boolean  "got_comments",                                     :default => false
    t.string   "frontend_article_image_file_name"
    t.string   "frontend_article_image_content_type"
    t.integer  "frontend_article_image_file_size"
    t.datetime "frontend_article_image_updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string  "name",                   :null => false
    t.integer "region_id",              :null => false
    t.string  "code",      :limit => 4, :null => false
  end

  create_table "dialogue_participants", :force => true do |t|
    t.datetime "registered_time",                                            :null => false
    t.string   "first_name",                                                 :null => false
    t.string   "middle_name",              :limit => 64
    t.string   "last_name",                                                  :null => false
    t.string   "address1",                                :default => "",    :null => false
    t.string   "address2"
    t.string   "zipcode",                  :limit => 10,  :default => "",    :null => false
    t.string   "city",                                    :default => "",    :null => false
    t.integer  "country_id",                              :default => 0,     :null => false
    t.string   "phone",                    :limit => 20,  :default => "",    :null => false
    t.string   "email",                    :limit => 100, :default => "",    :null => false
    t.string   "fax",                      :limit => 20
    t.string   "nationality",                             :default => "",    :null => false
    t.string   "passport",                                :default => "",    :null => false
    t.date     "birthdate",                                                  :null => false
    t.string   "sex",                      :limit => 2,   :default => "",    :null => false
    t.string   "university",                              :default => "",    :null => false
    t.string   "field_of_study",                                             :null => false
    t.string   "org_name"
    t.string   "org_function"
    t.string   "hear_about_isfit"
    t.string   "hear_about_isfit_other"
    t.text     "essay1",                                                     :null => false
    t.text     "essay2",                                                     :null => false
    t.text     "essay3",                                                     :null => false
    t.text     "essay4",                                                     :null => false
    t.integer  "travel_apply",             :limit => 1,   :default => 0
    t.text     "travel_essay"
    t.string   "travel_amount",            :limit => 20
    t.integer  "travel_nosupport_other",   :limit => 1,   :default => 0
    t.integer  "travel_nosupport_cancome", :limit => 1,   :default => 0
    t.integer  "apply_workshop",           :limit => 1,   :default => 0
    t.integer  "invited",                  :limit => 1,   :default => 0,     :null => false
    t.string   "password"
    t.datetime "last_login"
    t.boolean  "notified_invited",                        :default => false, :null => false
    t.boolean  "notified_rejected",                       :default => false, :null => false
  end

  add_index "dialogue_participants", ["email"], :name => "email", :unique => true

  create_table "donations", :force => true do |t|
    t.string   "status"
    t.float    "amount"
    t.string   "transaction_number"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "faqs", :force => true do |t|
    t.string "title", :null => false
    t.text   "body",  :null => false
  end

  create_table "festivals", :id => false, :force => true do |t|
    t.integer "id",   :default => 0, :null => false
    t.integer "year"
  end

  create_table "groups", :id => false, :force => true do |t|
    t.integer "id",                             :default => 0, :null => false
    t.string  "name_en"
    t.string  "name_no"
    t.integer "section_id"
    t.integer "festival_id"
    t.string  "email",          :limit => 1000
    t.string  "tag",                                           :null => false
    t.text    "description_en"
    t.text    "description_no"
  end

  create_table "groups_positions", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "position_id"
  end

  create_table "hosts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "address"
    t.integer  "zipcode"
    t.string   "place"
    t.integer  "number"
    t.text     "other"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ideas", :force => true do |t|
    t.string   "email"
    t.text     "body"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "like_count"
    t.string   "submitted_by_name"
    t.string   "submitted_by_id"
  end

  create_table "oauth_users", :force => true do |t|
    t.string   "token"
    t.string   "facebook_id"
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "pages", :force => true do |t|
    t.string  "title_en",                      :null => false
    t.string  "title_no",                      :null => false
    t.text    "ingress_en",                    :null => false
    t.text    "ingress_no",                    :null => false
    t.text    "body_en",                       :null => false
    t.text    "body_no",                       :null => false
    t.string  "tag",                           :null => false
    t.boolean "deleted",    :default => false, :null => false
  end

  create_table "participants", :force => true do |t|
    t.datetime "registered_time",                                              :null => false
    t.datetime "checked_in"
    t.datetime "picked_up"
    t.string   "first_name",                                                   :null => false
    t.string   "middle_name",                :limit => 64
    t.string   "last_name",                                                    :null => false
    t.string   "address1",                                  :default => "",    :null => false
    t.string   "address2"
    t.string   "zipcode",                    :limit => 10,  :default => "",    :null => false
    t.string   "city",                                      :default => "",    :null => false
    t.integer  "country_id",                                :default => 0,     :null => false
    t.string   "phone",                      :limit => 64,                     :null => false
    t.string   "email",                      :limit => 100, :default => "",    :null => false
    t.string   "fax",                        :limit => 20
    t.string   "nationality",                               :default => "",    :null => false
    t.date     "birthdate",                                                    :null => false
    t.string   "sex",                        :limit => 2,   :default => "",    :null => false
    t.string   "university",                                :default => "",    :null => false
    t.string   "field_of_study",                                               :null => false
    t.string   "org_name"
    t.string   "org_function"
    t.string   "hear_about_isfit"
    t.string   "hear_about_isfit_other"
    t.integer  "workshop1",                                 :default => 0,     :null => false
    t.integer  "workshop2",                                 :default => 0,     :null => false
    t.integer  "workshop3",                                 :default => 0,     :null => false
    t.text     "essay1",                                                       :null => false
    t.text     "essay2",                                                       :null => false
    t.integer  "travel_apply",               :limit => 1,   :default => 0
    t.text     "travel_essay"
    t.string   "travel_amount",              :limit => 20
    t.integer  "travel_nosupport_other",     :limit => 1,   :default => 0
    t.integer  "travel_nosupport_cancome",   :limit => 1,   :default => 0
    t.integer  "participant_grade",          :limit => 1,   :default => 0,     :null => false
    t.text     "participant_comment"
    t.integer  "participant_functionary_id",                :default => 0,     :null => false
    t.integer  "theme_grade1",               :limit => 1,   :default => 1,     :null => false
    t.integer  "theme_grade2",               :limit => 1,   :default => 1,     :null => false
    t.text     "theme_comment"
    t.text     "theme_comment_2"
    t.integer  "theme_functionary_id_2",                    :default => 0
    t.integer  "theme_functionary_id",                      :default => 0,     :null => false
    t.string   "password"
    t.integer  "final_workshop",                            :default => 0,     :null => false
    t.integer  "invited",                    :limit => 1,   :default => 0,     :null => false
    t.integer  "travel_assigned",            :limit => 1,   :default => 0,     :null => false
    t.integer  "travel_assigned_amount",                    :default => 0,     :null => false
    t.text     "travel_comment"
    t.integer  "host_id"
    t.datetime "last_login"
    t.boolean  "notified_invitation",                       :default => false, :null => false
    t.boolean  "notified_travel_support",                   :default => false, :null => false
    t.boolean  "notified_rejection",                        :default => false, :null => false
    t.boolean  "notified_no_travel_support",                :default => false, :null => false
    t.boolean  "notified_rejection_again",                  :default => false, :null => false
    t.date     "arrival_date"
    t.string   "arrival_place",              :limit => 100
    t.time     "arrival_time"
    t.string   "arrival_carrier",            :limit => 5
    t.boolean  "arrival_isfit_trans"
    t.string   "arrival_airline",            :limit => 30
    t.string   "arrival_flight_number",      :limit => 10
    t.date     "departure_date"
    t.time     "departure_time"
    t.string   "departure_carrier",          :limit => 5
    t.boolean  "departure_isfit_trans"
    t.string   "departure_place",            :limit => 100
    t.boolean  "notified_custom",                           :default => false, :null => false
    t.boolean  "blocked",                                   :default => false, :null => false
    t.datetime "request_travel"
    t.integer  "accept_travel",              :limit => 1
    t.datetime "accept_travel_time"
    t.integer  "bed",                        :limit => 1,   :default => 0,     :null => false
    t.integer  "bedding",                    :limit => 1,   :default => 0,     :null => false
    t.boolean  "special_invite",                            :default => false, :null => false
    t.boolean  "deleted",                                   :default => false
  end

  add_index "participants", ["email"], :name => "email", :unique => true

  create_table "positions", :id => false, :force => true do |t|
    t.integer  "id",             :default => 0, :null => false
    t.string   "title_en"
    t.string   "title_no"
    t.integer  "user_id"
    t.text     "description_en"
    t.text     "description_no"
    t.string   "group_dn"
    t.integer  "admission_id"
    t.integer  "group_id"
    t.integer  "number",         :default => 1, :null => false
    t.datetime "publish_from"
    t.datetime "publish_to"
  end

  create_table "project_supports", :force => true do |t|
    t.string   "person_name"
    t.integer  "person_age"
    t.integer  "country_id"
    t.string   "person_mail"
    t.string   "person_association"
    t.integer  "workshop_id"
    t.text     "group_description"
    t.text     "project_description"
    t.text     "funds_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", :force => true do |t|
    t.string "name", :limit => 64, :null => false
  end

  create_table "sections", :id => false, :force => true do |t|
    t.integer "id",                             :default => 0, :null => false
    t.string  "name_en"
    t.string  "name_no"
    t.integer "festival_id"
    t.string  "email",          :limit => 1000
    t.string  "tag",                                           :null => false
    t.text    "description_en"
    t.text    "description_no"
  end

  create_table "workshops", :force => true do |t|
    t.string   "name"
    t.text     "ingress"
    t.text     "body"
    t.integer  "number"
    t.integer  "user_id"
    t.boolean  "published"
    t.boolean  "got_comments"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "workshop_image_file_name"
    t.string   "workshop_image_content_type"
    t.integer  "workshop_image_file_size"
    t.datetime "workshop_image_updated_at"
  end

  add_index "workshops", ["user_id"], :name => "index_workshops_on_user_id"

end
