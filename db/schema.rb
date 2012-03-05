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

ActiveRecord::Schema.define(:version => 20110216230012) do

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
    t.text     "comment"
  end

# Could not dump table "articles" because of following ActiveRecord::StatementInvalid
#   Mysql2::Error: SHOW VIEW command denied to user 'isfit11_public'@'localhost' for table 'articles': SHOW CREATE TABLE `articles`

  create_table "articles_old", :force => true do |t|
    t.string   "title",                      :null => false
    t.text     "ingress"
    t.text     "body"
    t.boolean  "list",    :default => false, :null => false
    t.boolean  "promote", :default => false, :null => false
    t.integer  "weight",  :default => 1,     :null => false
    t.datetime "created"
  end

  create_table "blogs", :force => true do |t|
    t.string   "title",      :null => false
    t.text     "body",       :null => false
    t.string   "author",     :null => false
    t.datetime "created_at", :null => false
  end

# Could not dump table "chronicles" because of following ActiveRecord::StatementInvalid
#   Mysql2::Error: SHOW VIEW command denied to user 'isfit11_public'@'localhost' for table 'chronicles': SHOW CREATE TABLE `chronicles`

  create_table "countries", :force => true do |t|
    t.string  "name",      :null => false
    t.integer "region_id", :null => false
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

  create_table "downloads", :force => true do |t|
    t.integer "count", :default => 0, :null => false
  end

# Could not dump table "event_dates" because of following ActiveRecord::StatementInvalid
#   Mysql2::Error: SHOW VIEW command denied to user 'isfit11_public'@'localhost' for table 'event_dates': SHOW CREATE TABLE `event_dates`

# Could not dump table "event_places" because of following ActiveRecord::StatementInvalid
#   Mysql2::Error: SHOW VIEW command denied to user 'isfit11_public'@'localhost' for table 'event_places': SHOW CREATE TABLE `event_places`

# Could not dump table "event_types" because of following ActiveRecord::StatementInvalid
#   Mysql2::Error: SHOW VIEW command denied to user 'isfit11_public'@'localhost' for table 'event_types': SHOW CREATE TABLE `event_types`

# Could not dump table "events" because of following ActiveRecord::StatementInvalid
#   Mysql2::Error: SHOW VIEW command denied to user 'isfit11_public'@'localhost' for table 'events': SHOW CREATE TABLE `events`

  create_table "events_backup", :force => true do |t|
    t.string   "title",            :limit => 100,                    :null => false
    t.string   "event_type",       :limit => 0,                      :null => false
    t.datetime "date",                                               :null => false
    t.string   "place",            :limit => 100,                    :null => false
    t.integer  "price_member",                                       :null => false
    t.integer  "price_other",                                        :null => false
    t.string   "ingress",                                            :null => false
    t.text     "description",                                        :null => false
    t.integer  "related_event_id"
    t.boolean  "deleted",                         :default => false, :null => false
    t.boolean  "important",                                          :null => false
    t.boolean  "visible",                                            :null => false
    t.string   "url",                                                :null => false
  end

  create_table "faqs", :force => true do |t|
    t.string "title", :null => false
    t.text   "body",  :null => false
  end

  create_table "funds", :force => true do |t|
    t.string  "name",                                :null => false
    t.string  "initiator",                           :null => false
    t.string  "email",                               :null => false
    t.string  "address",                             :null => false
    t.string  "country",               :limit => 40, :null => false
    t.string  "phone",                               :null => false
    t.integer "isfit_connection",      :limit => 1,  :null => false
    t.integer "isfit_connection_year",               :null => false
    t.string  "amount",                :limit => 20, :null => false
    t.text    "account_details",                     :null => false
    t.text    "purpose_text"
    t.text    "plans_text"
    t.text    "further_funding_plan",                :null => false
    t.text    "other_info",                          :null => false
  end

# Could not dump table "groups" because of following ActiveRecord::StatementInvalid
#   Mysql2::Error: SHOW VIEW command denied to user 'isfit11_public'@'localhost' for table 'groups': SHOW CREATE TABLE `groups`

# Could not dump table "groups_positions" because of following ActiveRecord::StatementInvalid
#   Mysql2::Error: SHOW VIEW command denied to user 'isfit11_public'@'localhost' for table 'groups_positions': SHOW CREATE TABLE `groups_positions`

  create_table "hosts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "address"
    t.integer  "zipcode"
    t.string   "place"
    t.integer  "age"
    t.boolean  "before"
    t.text     "why"
    t.string   "where"
    t.integer  "number"
    t.integer  "skies"
    t.boolean  "arrival_before"
    t.boolean  "leave_late"
    t.text     "preference"
    t.string   "pet"
    t.text     "know_isfit"
    t.string   "member_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "vegetarian"
    t.boolean  "smoker"
    t.string   "animal"
    t.integer  "animal_number"
    t.string   "language_speak"
  end

  create_table "isfit_media_links", :force => true do |t|
    t.string    "link"
    t.string    "short_desc_no"
    t.string    "short_desc_en"
    t.string    "long_desc_no"
    t.string    "long_desc_en"
    t.integer   "deleted",       :default => 0, :null => false
    t.timestamp "created_at",                   :null => false
  end

# Could not dump table "pages" because of following ActiveRecord::StatementInvalid
#   Mysql2::Error: SHOW VIEW command denied to user 'isfit11_public'@'localhost' for table 'pages': SHOW CREATE TABLE `pages`

  create_table "pages_old", :force => true do |t|
    t.string  "title_en",                               :null => false
    t.string  "title_no",                               :null => false
    t.text    "ingress_en",                             :null => false
    t.text    "ingress_no",                             :null => false
    t.text    "body_en",                                :null => false
    t.text    "body_no",                                :null => false
    t.string  "tag",                                    :null => false
    t.integer "deleted",    :limit => 1, :default => 0, :null => false
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
    t.integer  "deleted",                                   :default => 0
  end

  add_index "participants", ["email"], :name => "email", :unique => true

  create_table "participants_copy", :force => true do |t|
    t.datetime "registered_time",                                           :null => false
    t.datetime "checked_in"
    t.datetime "picked_up"
    t.string   "first_name",                                                :null => false
    t.string   "middle_name",                :limit => 64
    t.string   "last_name",                                                 :null => false
    t.string   "address1",                                  :default => "", :null => false
    t.string   "address2"
    t.string   "zipcode",                    :limit => 10,  :default => "", :null => false
    t.string   "city",                                      :default => "", :null => false
    t.integer  "country_id",                                :default => 0,  :null => false
    t.string   "phone",                      :limit => 64,                  :null => false
    t.string   "email",                      :limit => 100, :default => "", :null => false
    t.string   "fax",                        :limit => 20
    t.string   "nationality",                               :default => "", :null => false
    t.date     "birthdate",                                                 :null => false
    t.string   "sex",                        :limit => 2,   :default => "", :null => false
    t.string   "university",                                :default => "", :null => false
    t.string   "field_of_study",                                            :null => false
    t.string   "org_name"
    t.string   "org_function"
    t.string   "hear_about_isfit"
    t.string   "hear_about_isfit_other"
    t.integer  "workshop1",                                 :default => 0,  :null => false
    t.integer  "workshop2",                                 :default => 0,  :null => false
    t.text     "essay1",                                                    :null => false
    t.text     "essay2",                                                    :null => false
    t.integer  "travel_apply",               :limit => 1,   :default => 0
    t.text     "travel_essay"
    t.string   "travel_amount",              :limit => 20
    t.integer  "travel_nosupport_other",     :limit => 1,   :default => 0
    t.integer  "travel_nosupport_cancome",   :limit => 1,   :default => 0
    t.integer  "participant_grade",          :limit => 1,                   :null => false
    t.text     "participant_comment",                                       :null => false
    t.integer  "participant_functionary_id",                                :null => false
    t.integer  "theme_grade1",               :limit => 1,   :default => 1,  :null => false
    t.integer  "theme_grade2",               :limit => 1,   :default => 1,  :null => false
    t.text     "theme_comment",                                             :null => false
    t.integer  "theme_functionary_id",                                      :null => false
    t.string   "password"
    t.integer  "final_workshop",                                            :null => false
    t.integer  "invited",                    :limit => 1,                   :null => false
    t.integer  "travel_assigned",            :limit => 1,                   :null => false
    t.integer  "travel_assigned_amount",                                    :null => false
    t.text     "travel_comment",                                            :null => false
    t.integer  "host_id"
    t.datetime "last_login"
    t.boolean  "notified_invitation",                                       :null => false
    t.boolean  "notified_travel_support",                                   :null => false
    t.boolean  "notified_rejection",                                        :null => false
    t.boolean  "notified_no_travel_support",                                :null => false
    t.boolean  "notified_rejection_again",                                  :null => false
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
    t.boolean  "notified_custom",                                           :null => false
    t.boolean  "blocked",                                                   :null => false
    t.datetime "request_travel"
    t.integer  "accept_travel",              :limit => 1
    t.datetime "accept_travel_time"
  end

  add_index "participants_copy", ["email"], :name => "email", :unique => true

  create_table "personal_contacts", :force => true do |t|
    t.string  "firstname",                                  :null => false
    t.string  "lastname",                                   :null => false
    t.string  "address",                                    :null => false
    t.integer "zip_code",                                   :null => false
    t.string  "email",                                      :null => false
    t.integer "country_id",                                 :null => false
    t.string  "city",                                       :null => false
    t.integer "infopackage_contact_type_id", :default => 1, :null => false
  end

# Could not dump table "photos" because of following ActiveRecord::StatementInvalid
#   Mysql2::Error: SHOW VIEW command denied to user 'isfit11_public'@'localhost' for table 'photos': SHOW CREATE TABLE `photos`

# Could not dump table "positions" because of following ActiveRecord::StatementInvalid
#   Mysql2::Error: SHOW VIEW command denied to user 'isfit11_public'@'localhost' for table 'positions': SHOW CREATE TABLE `positions`

  create_table "positions_bak", :force => true do |t|
    t.text    "title_no"
    t.text    "description_no"
    t.text    "title_en"
    t.text    "description_en"
    t.boolean "deleted",                     :default => false, :null => false
    t.integer "section_id",                                     :null => false
    t.string  "group_dn"
    t.integer "admission_nr",   :limit => 1, :default => 0,     :null => false
  end

  create_table "press_accreditations", :force => true do |t|
    t.string   "organization"
    t.string   "firstname"
    t.string   "surname"
    t.string   "function"
    t.string   "day_period"
    t.boolean  "access_whole_festival"
    t.string   "email"
    t.string   "phone"
    t.string   "birth"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

# Could not dump table "press_releases" because of following ActiveRecord::StatementInvalid
#   Mysql2::Error: SHOW VIEW command denied to user 'isfit11_public'@'localhost' for table 'press_releases': SHOW CREATE TABLE `press_releases`

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

  create_table "questions", :force => true do |t|
    t.integer  "participant_id",                                :null => false
    t.datetime "question_datetime",                             :null => false
    t.string   "subject"
    t.text     "question",                                      :null => false
    t.integer  "functionary_id"
    t.datetime "answer_datetime"
    t.text     "answer"
    t.integer  "is_read",           :limit => 1, :default => 0, :null => false
    t.string   "recipient",         :limit => 0,                :null => false
    t.string   "participant_type",  :limit => 0,                :null => false
  end

  create_table "regions", :force => true do |t|
    t.string "name", :limit => 64, :null => false
  end

  create_table "schema_info", :id => false, :force => true do |t|
    t.integer "version"
  end

# Could not dump table "sections" because of following ActiveRecord::StatementInvalid
#   Mysql2::Error: SHOW VIEW command denied to user 'isfit11_public'@'localhost' for table 'sections': SHOW CREATE TABLE `sections`

  create_table "sections_bak", :force => true do |t|
    t.string "name_no", :limit => 64, :null => false
    t.string "name_en", :limit => 32, :null => false
  end

# Could not dump table "slides" because of following ActiveRecord::StatementInvalid
#   Mysql2::Error: SHOW VIEW command denied to user 'isfit11_public'@'localhost' for table 'slides': SHOW CREATE TABLE `slides`

# Could not dump table "spp_articles" because of following ActiveRecord::StatementInvalid
#   Mysql2::Error: SHOW VIEW command denied to user 'isfit11_public'@'localhost' for table 'spp_articles': SHOW CREATE TABLE `spp_articles`

# Could not dump table "sublinks" because of following ActiveRecord::StatementInvalid
#   Mysql2::Error: SHOW VIEW command denied to user 'isfit11_public'@'localhost' for table 'sublinks': SHOW CREATE TABLE `sublinks`

  create_table "sublinks_old", :force => true do |t|
    t.integer "tab_id",                          :null => false
    t.text    "title_en",                        :null => false
    t.text    "title_no",                        :null => false
    t.text    "url"
    t.text    "external_url"
    t.integer "order",                           :null => false
    t.boolean "deleted",      :default => false, :null => false
    t.integer "page_id",                         :null => false
  end

  create_table "sublinks_old2", :force => true do |t|
    t.integer "tab_id",                          :null => false
    t.text    "title_en",                        :null => false
    t.text    "title_no",                        :null => false
    t.text    "url"
    t.text    "external_url"
    t.integer "order",                           :null => false
    t.boolean "deleted",      :default => false, :null => false
    t.integer "page_id",      :default => 0
  end

# Could not dump table "tabs" because of following ActiveRecord::StatementInvalid
#   Mysql2::Error: SHOW VIEW command denied to user 'isfit11_public'@'localhost' for table 'tabs': SHOW CREATE TABLE `tabs`

  create_table "tabs_old", :force => true do |t|
    t.string  "name_en", :limit => 32, :null => false
    t.string  "name_no", :limit => 32, :null => false
    t.string  "tag",     :limit => 32, :null => false
    t.integer "order",   :limit => 1,  :null => false
  end

  create_table "tabs_old2", :force => true do |t|
    t.string  "name_en", :limit => 32, :null => false
    t.string  "name_no", :limit => 32, :null => false
    t.string  "tag",     :limit => 32, :null => false
    t.integer "weight",  :limit => 1,  :null => false
    t.boolean "top_bar"
  end

  create_table "wop_propositions", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "phone"
    t.string   "email"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "address"
    t.integer  "zipcode"
    t.string   "study_place"
    t.integer  "description",             :null => false
  end

  create_table "workshops", :force => true do |t|
    t.string   "name",           :limit => 64, :null => false
    t.text     "description",                  :null => false
    t.string   "location",                     :null => false
    t.string   "title_en"
    t.string   "title_no"
    t.text     "ingress_en"
    t.text     "ingress_no"
    t.text     "body_en"
    t.text     "body_no"
    t.boolean  "list"
    t.integer  "weight"
    t.string   "sub_title_no"
    t.string   "sub_title_en"
    t.string   "image_text_no"
    t.string   "image_text_en"
    t.boolean  "main_article"
    t.boolean  "published"
    t.string   "byline"
    t.integer  "byline_func_id"
    t.string   "image_credits"
    t.integer  "mail_sent"
    t.datetime "show_article"
    t.boolean  "got_comments"
    t.boolean  "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
