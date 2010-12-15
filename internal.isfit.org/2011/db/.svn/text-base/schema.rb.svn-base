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

ActiveRecord::Schema.define(:version => 20100814200219) do

  create_table "answers", :force => true do |t|
    t.integer "attend",               :limit => 4
    t.string  "visa",                 :limit => 0
    t.string  "stay_with",            :limit => 0
    t.integer "smoke",                :limit => 4
    t.integer "handicap",             :limit => 4
    t.text    "handicap_description"
    t.text    "food_description"
    t.integer "no_special",           :limit => 4
    t.integer "vegetarian",           :limit => 4
    t.integer "lactose",              :limit => 4
    t.integer "gluten",               :limit => 4
    t.integer "kosher",               :limit => 4
    t.integer "halal",                :limit => 4
    t.integer "other",                :limit => 4
  end

  create_table "applicants", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "mail"
    t.integer  "phone",              :limit => 11
    t.text     "information"
    t.text     "background"
    t.text     "heardof"
    t.integer  "position_id_1",      :limit => 11,                     :null => false
    t.integer  "position_id_2",      :limit => 11
    t.integer  "position_id_3",      :limit => 11
    t.integer  "status",             :limit => 11,  :default => 0
    t.string   "interview_place_1"
    t.string   "interview_place_2"
    t.string   "interview_place_3"
    t.datetime "interview_time_1"
    t.datetime "interview_time_2"
    t.datetime "interview_time_3"
    t.integer  "interviewer_id_1_1", :limit => 11
    t.integer  "interviewer_id_1_2", :limit => 11
    t.integer  "interviewer_id_2_1", :limit => 11
    t.integer  "interviewer_id_2_2", :limit => 11
    t.integer  "interviewer_id_3_1", :limit => 11
    t.integer  "interviewer_id_3_2", :limit => 11
    t.boolean  "deleted",                           :default => false, :null => false
    t.string   "username"
    t.string   "password",           :limit => 16
    t.string   "dn",                 :limit => 512
    t.integer  "has_account",        :limit => 4,   :default => 0,     :null => false
    t.integer  "is_notified",        :limit => 11,  :default => 0,     :null => false
  end

  create_table "applicants_old", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "mail"
    t.integer  "phone",              :limit => 11
    t.text     "information"
    t.text     "background"
    t.integer  "position_id_1",      :limit => 11
    t.integer  "position_id_2",      :limit => 11
    t.integer  "position_id_3",      :limit => 11
    t.integer  "status",             :limit => 11
    t.string   "interview_place_1"
    t.string   "interview_place_2"
    t.string   "interview_place_3"
    t.datetime "interview_time_1"
    t.datetime "interview_time_2"
    t.datetime "interview_time_3"
    t.integer  "interviewer_id_1_1", :limit => 11
    t.integer  "interviewer_id_1_2", :limit => 11
    t.integer  "interviewer_id_2_1", :limit => 11
    t.integer  "interviewer_id_2_2", :limit => 11
    t.integer  "interviewer_id_3_1", :limit => 11
    t.integer  "interviewer_id_3_2", :limit => 11
    t.boolean  "deleted"
    t.string   "username"
    t.string   "password",           :limit => 16
    t.string   "dn",                 :limit => 512
    t.integer  "has_account",        :limit => 4
    t.integer  "is_notified",        :limit => 11
  end

  create_table "articles", :force => true do |t|
    t.string   "title",                                        :null => false
    t.text     "body",                                         :null => false
    t.datetime "created_at",                                   :null => false
    t.integer  "user_id",    :limit => 11,                     :null => false
    t.string   "group_dn",   :limit => 512,                    :null => false
    t.boolean  "deleted",                   :default => false, :null => false
    t.integer  "sticky",     :limit => 4,   :default => 0,     :null => false
    t.datetime "end_at",                                       :null => false
    t.string   "byline"
  end

  create_table "blogs", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "author"
    t.datetime "created_at"
  end

  create_table "calendar_events", :force => true do |t|
    t.string   "title",      :limit => 30,                    :null => false
    t.text     "body"
    t.datetime "start",                                       :null => false
    t.datetime "stop",                                        :null => false
    t.datetime "created_at",                                  :null => false
    t.integer  "user_id",    :limit => 11,                    :null => false
    t.string   "group_dn",                                    :null => false
    t.integer  "deleted",    :limit => 4,  :default => 0,     :null => false
    t.boolean  "attendants",               :default => false, :null => false
  end

  create_table "car_reservations", :force => true do |t|
    t.integer  "car_id",    :limit => 5,  :null => false
    t.integer  "user_id",   :limit => 5,  :null => false
    t.string   "group_dn",                :null => false
    t.datetime "time_from",               :null => false
    t.datetime "time_to",                 :null => false
    t.string   "from",      :limit => 64, :null => false
    t.string   "to",        :limit => 64, :null => false
    t.text     "route",                   :null => false
    t.text     "comment",                 :null => false
    t.integer  "deleted",   :limit => 4
  end

  create_table "cars", :force => true do |t|
    t.string  "name",              :limit => 32, :null => false
    t.text    "description"
    t.string  "short_description", :limit => 32, :null => false
    t.integer "max_passengers",    :limit => 2,  :null => false
    t.integer "transport_only",    :limit => 4,  :null => false
    t.integer "deleted",           :limit => 1,  :null => false
  end

  create_table "chronicles", :force => true do |t|
    t.string   "title_en"
    t.string   "title_no"
    t.text     "ingress_en"
    t.text     "ingress_no"
    t.text     "body_en"
    t.text     "body_no"
    t.string   "author"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "weight",     :limit => 11
  end

  create_table "comments", :force => true do |t|
    t.timestamp "registered_time",               :null => false
    t.string    "isfit_user",      :limit => 64, :null => false
    t.text      "comment_text",                  :null => false
    t.integer   "contact_id",      :limit => 11, :null => false
  end

  create_table "comments_unknown", :force => true do |t|
    t.datetime "registered_at"
    t.text     "body"
    t.string   "name",          :limit => 64
    t.string   "email",         :limit => 64
    t.integer  "blog_id",       :limit => 4
    t.integer  "approved",      :limit => 4
    t.integer  "deleted",       :limit => 4
  end

  create_table "contact_relations", :force => true do |t|
    t.integer "contact_id",     :limit => 11, :null => false
    t.integer "contact_via_id", :limit => 11, :null => false
  end

  create_table "contact_responsibles", :force => true do |t|
    t.integer "contact_id",     :limit => 11, :null => false
    t.integer "responsible_id", :limit => 11, :null => false
  end

  create_table "contacts", :force => true do |t|
    t.string  "first_name",        :limit => 64,                :null => false
    t.string  "last_name",         :limit => 64,                :null => false
    t.string  "phone1",            :limit => 64
    t.string  "phone2",            :limit => 64
    t.string  "email",             :limit => 64
    t.string  "organization",      :limit => 64
    t.string  "position"
    t.string  "address1",          :limit => 64
    t.string  "address2",          :limit => 64
    t.string  "city",              :limit => 64
    t.string  "zip",               :limit => 64
    t.integer "country_id",        :limit => 11
    t.string  "fax",               :limit => 64
    t.string  "isfit_responsible", :limit => 64
    t.string  "status",            :limit => 0,                 :null => false
    t.integer "delete",            :limit => 4,  :default => 0, :null => false
  end

  create_table "countries", :force => true do |t|
    t.string  "name",                    :null => false
    t.integer "region_id", :limit => 11, :null => false
  end

  create_table "dialogue_participants", :force => true do |t|
    t.datetime "registered_time",                                         :null => false
    t.string   "first_name",                                              :null => false
    t.string   "middle_name",              :limit => 64
    t.string   "last_name",                                               :null => false
    t.string   "address1",                                :default => "", :null => false
    t.string   "address2"
    t.string   "zipcode",                  :limit => 10,  :default => "", :null => false
    t.string   "city",                                    :default => "", :null => false
    t.integer  "country_id",               :limit => 11,  :default => 0,  :null => false
    t.string   "phone",                    :limit => 20,  :default => "", :null => false
    t.string   "email",                    :limit => 100, :default => "", :null => false
    t.string   "fax",                      :limit => 20
    t.string   "nationality",                             :default => "", :null => false
    t.string   "passport",                                :default => "", :null => false
    t.date     "birthdate",                                               :null => false
    t.string   "sex",                      :limit => 2,   :default => "", :null => false
    t.string   "university",                              :default => "", :null => false
    t.string   "field_of_study",                                          :null => false
    t.string   "org_name"
    t.string   "org_function"
    t.string   "hear_about_isfit"
    t.string   "hear_about_isfit_other"
    t.text     "essay1",                                                  :null => false
    t.text     "essay2",                                                  :null => false
    t.text     "essay3",                                                  :null => false
    t.text     "essay4",                                                  :null => false
    t.integer  "travel_apply",             :limit => 4,   :default => 0
    t.text     "travel_essay"
    t.string   "travel_amount",            :limit => 20
    t.integer  "travel_nosupport_other",   :limit => 4,   :default => 0
    t.integer  "travel_nosupport_cancome", :limit => 4,   :default => 0
    t.integer  "apply_workshop",           :limit => 4,   :default => 0
    t.integer  "invited",                  :limit => 4,                   :null => false
    t.string   "password"
  end

  add_index "dialogue_participants", ["email"], :name => "email", :unique => true

  create_table "economy_contact_logs", :force => true do |t|
    t.integer "economy_contact_unit_id", :limit => 11,                :null => false
    t.integer "festival_id",             :limit => 11,                :null => false
    t.text    "body",                                                 :null => false
    t.text    "advice",                                               :null => false
    t.string  "author",                  :limit => 64
    t.integer "functionary_id",          :limit => 11,                :null => false
    t.integer "deleted",                 :limit => 4,  :default => 0, :null => false
  end

  create_table "economy_contact_people", :force => true do |t|
    t.integer "economy_contact_unit_id", :limit => 11,                 :null => false
    t.string  "title",                   :limit => 64,                 :null => false
    t.string  "firstname",               :limit => 64,                 :null => false
    t.string  "lastname",                :limit => 64,                 :null => false
    t.string  "phone1",                  :limit => 20,                 :null => false
    t.string  "phone2",                  :limit => 20,                 :null => false
    t.string  "email",                   :limit => 128,                :null => false
    t.text    "comment",                                               :null => false
    t.integer "deleted",                 :limit => 4,   :default => 0
  end

  create_table "economy_contact_unit_types", :force => true do |t|
    t.string "name", :limit => 64, :null => false
  end

  create_table "economy_contact_units", :force => true do |t|
    t.integer "economy_contact_unit_type_id", :limit => 11,  :null => false
    t.string  "name",                                        :null => false
    t.string  "address",                      :limit => 128, :null => false
    t.string  "zipcode",                      :limit => 16,  :null => false
    t.string  "city",                         :limit => 32,  :null => false
    t.string  "country",                      :limit => 32,  :null => false
    t.string  "phone",                        :limit => 20,  :null => false
    t.string  "email",                        :limit => 128, :null => false
    t.string  "homepage",                     :limit => 256, :null => false
    t.integer "economy_contact_person_id",    :limit => 11
  end

  create_table "event_attendants", :force => true do |t|
    t.integer "event_id", :limit => 11,                :null => false
    t.integer "user_id",  :limit => 11,                :null => false
    t.integer "rsvp",     :limit => 9,  :default => 0, :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "title",            :limit => 100
    t.string   "event_type",       :limit => 0
    t.datetime "date"
    t.string   "place",            :limit => 100
    t.integer  "price_member",     :limit => 11
    t.integer  "price_other",      :limit => 11
    t.string   "ingress"
    t.text     "description"
    t.integer  "related_event_id", :limit => 11
    t.boolean  "deleted"
    t.boolean  "important"
    t.boolean  "visible"
    t.string   "url"
  end

  create_table "faqs", :force => true do |t|
    t.string  "title",   :limit => 50,                    :null => false
    t.text    "body",                                     :null => false
    t.boolean "deleted",               :default => false, :null => false
  end

  create_table "festivals", :force => true do |t|
    t.string "name", :limit => 50, :null => false
  end

  create_table "food_orders", :force => true do |t|
    t.integer "user_id",  :limit => 11, :null => false
    t.integer "meal_id",  :limit => 4,  :null => false
    t.string  "group_id",               :null => false
    t.integer "day",      :limit => 4,  :null => false
    t.integer "will_eat", :limit => 4,  :null => false
  end

  create_table "forum_posts", :force => true do |t|
    t.text     "body",                                             :null => false
    t.integer  "user_id",         :limit => 11,                    :null => false
    t.integer  "forum_thread_id", :limit => 11,                    :null => false
    t.datetime "created_at",                                       :null => false
    t.boolean  "deleted",                       :default => false, :null => false
  end

  create_table "forum_thread_visits", :id => false, :force => true do |t|
    t.integer "user_id",         :limit => 11, :null => false
    t.integer "forum_thread_id", :limit => 11, :null => false
  end

  create_table "forum_threads", :force => true do |t|
    t.integer "forum_id", :limit => 11, :null => false
    t.text    "title",                  :null => false
  end

  create_table "forums", :force => true do |t|
    t.string "group_dn", :limit => 512, :null => false
    t.string "name",                    :null => false
  end

  create_table "frontend_articles", :force => true do |t|
    t.string   "title_en"
    t.string   "title_no"
    t.text     "ingress_en"
    t.text     "ingress_no"
    t.text     "body_en"
    t.text     "body_no"
    t.boolean  "list"
    t.integer  "weight",         :limit => 11
    t.datetime "created_at"
    t.boolean  "deleted"
    t.integer  "press_release",  :limit => 4
    t.string   "sub_title_no"
    t.string   "sub_title_en"
    t.string   "image_text_no"
    t.string   "image_text_en"
    t.boolean  "main_article"
    t.boolean  "published"
    t.string   "byline"
    t.integer  "byline_func_id", :limit => 11, :null => false
    t.string   "image_credits"
  end

  create_table "frontend_tabs", :force => true do |t|
    t.string  "name_en", :limit => 32, :null => false
    t.string  "name_no", :limit => 32, :null => false
    t.string  "tag",     :limit => 32, :null => false
    t.integer "order",   :limit => 4,  :null => false
    t.boolean "top_bar"
  end

  create_table "functionaries", :force => true do |t|
    t.integer "vegetarian",           :limit => 4
    t.integer "lactose",              :limit => 4
    t.integer "gluten",               :limit => 4
    t.integer "nut_allergy",          :limit => 4
    t.integer "fruit",                :limit => 4
    t.text    "other"
    t.integer "no_allergies",         :limit => 4
    t.boolean "read_contact_eula",                  :default => false, :null => false
    t.string  "next_of_kin_name",     :limit => 64
    t.string  "next_of_kin_tlf",      :limit => 16
    t.text    "tasks"
    t.integer "study_place",          :limit => 11
    t.string  "study",                :limit => 64
    t.string  "private_mail",         :limit => 64
    t.integer "cardnumber_ntnu",      :limit => 11
    t.integer "cardnumber_samfundet", :limit => 11
    t.integer "cardnumber_isfit",     :limit => 11
    t.integer "have_group_card",      :limit => 4,  :default => -1,    :null => false
    t.integer "has_skies",            :limit => 4,  :default => -1,    :null => false
    t.integer "shoe_size",            :limit => 4,                     :null => false
  end

  create_table "gallery_comments", :force => true do |t|
    t.timestamp "created_at",               :null => false
    t.string    "isfit_user", :limit => 64, :null => false
    t.text      "text",                     :null => false
    t.string    "image",                    :null => false
  end

  create_table "groups", :force => true do |t|
    t.string  "name_en"
    t.string  "name_no"
    t.integer "section_id",  :limit => 11
    t.integer "festival_id", :limit => 11
  end

  create_table "hosts", :force => true do |t|
    t.string  "first_name",     :limit => 30, :null => false
    t.string  "last_name",      :limit => 30, :null => false
    t.string  "email",          :limit => 30, :null => false
    t.string  "phone",          :limit => 30, :null => false
    t.string  "address",        :limit => 50, :null => false
    t.integer "zipcode",        :limit => 4,  :null => false
    t.string  "place",          :limit => 30, :null => false
    t.integer "age",            :limit => 2,  :null => false
    t.boolean "before",                       :null => false
    t.text    "why",                          :null => false
    t.string  "where",                        :null => false
    t.integer "number",         :limit => 2,  :null => false
    t.boolean "skies",                        :null => false
    t.boolean "arrival_before",               :null => false
    t.boolean "leave_late",                   :null => false
    t.text    "preference",                   :null => false
    t.string  "pet"
    t.text    "know_isfit",                   :null => false
    t.string  "member_name",    :limit => 64, :null => false
  end

  create_table "imf_contact_comments", :force => true do |t|
    t.integer  "functionary_id",      :limit => 11
    t.text     "content"
    t.integer  "imf_contact_unit_id", :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "deleted",             :limit => 4,  :default => 0
  end

  create_table "imf_contact_statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "imf_contact_units", :force => true do |t|
    t.integer  "imf_contact_status_id", :limit => 11, :default => 1, :null => false
    t.string   "name"
    t.string   "address"
    t.string   "street"
    t.string   "zip_code"
    t.integer  "country_id",            :limit => 11
    t.string   "file_path"
    t.integer  "ldap_responsible_id",   :limit => 11
    t.integer  "ldap_sent_person_id",   :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "city"
  end

  create_table "infopackage_contacts_types", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "isfit_media_links", :force => true do |t|
    t.string    "link"
    t.string    "short_desc_no"
    t.string    "short_desc_en"
    t.string    "long_desc_no"
    t.string    "long_desc_en"
    t.integer   "deleted",       :limit => 11, :default => 0, :null => false
    t.timestamp "created_at",                                 :null => false
  end

  create_table "menu_link_groups", :force => true do |t|
    t.integer "menu_tab_id", :limit => 11, :null => false
    t.string  "title",       :limit => 32, :null => false
  end

  create_table "menu_links", :force => true do |t|
    t.integer "menu_link_group_id", :limit => 11, :null => false
    t.string  "title",              :limit => 32, :null => false
    t.string  "controller",         :limit => 40, :null => false
    t.string  "action",             :limit => 40, :null => false
  end

  create_table "menu_tabs", :force => true do |t|
    t.string "title", :limit => 32, :null => false
  end

  create_table "pages", :force => true do |t|
    t.string  "title_en",                               :null => false
    t.string  "title_no",                               :null => false
    t.text    "ingress_en",                             :null => false
    t.text    "ingress_no",                             :null => false
    t.text    "body_en",                                :null => false
    t.text    "body_no",                                :null => false
    t.string  "tag",                                    :null => false
    t.integer "deleted",    :limit => 4, :default => 0, :null => false
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
    t.integer  "country_id",                 :limit => 11,  :default => 0,     :null => false
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
    t.integer  "workshop1",                  :limit => 11,  :default => 0,     :null => false
    t.integer  "workshop2",                  :limit => 11,  :default => 0,     :null => false
    t.text     "essay1",                                                       :null => false
    t.text     "essay2",                                                       :null => false
    t.integer  "travel_apply",               :limit => 4,   :default => 0
    t.text     "travel_essay"
    t.string   "travel_amount",              :limit => 20
    t.integer  "travel_nosupport_other",     :limit => 4,   :default => 0
    t.integer  "travel_nosupport_cancome",   :limit => 4,   :default => 0
    t.integer  "participant_grade",          :limit => 4,                      :null => false
    t.text     "participant_comment",                                          :null => false
    t.integer  "participant_functionary_id", :limit => 11,                     :null => false
    t.integer  "theme_grade1",               :limit => 4,   :default => 1,     :null => false
    t.integer  "theme_grade2",               :limit => 4,   :default => 1,     :null => false
    t.text     "theme_comment",                                                :null => false
    t.integer  "theme_functionary_id",       :limit => 11,                     :null => false
    t.string   "password"
    t.integer  "final_workshop",             :limit => 11,                     :null => false
    t.integer  "invited",                    :limit => 4,                      :null => false
    t.integer  "travel_assigned",            :limit => 4,                      :null => false
    t.integer  "travel_assigned_amount",     :limit => 11,                     :null => false
    t.text     "travel_comment",                                               :null => false
    t.integer  "host_id",                    :limit => 11
    t.datetime "last_login"
    t.boolean  "notified_invitation",                                          :null => false
    t.boolean  "notified_travel_support",                                      :null => false
    t.boolean  "notified_rejection",                                           :null => false
    t.boolean  "notified_no_travel_support",                                   :null => false
    t.boolean  "notified_rejection_again",                                     :null => false
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
    t.boolean  "notified_custom",                                              :null => false
    t.boolean  "blocked",                                                      :null => false
    t.datetime "request_travel"
    t.integer  "accept_travel",              :limit => 4
    t.datetime "accept_travel_time"
    t.integer  "bed",                        :limit => 4,   :default => 0,     :null => false
    t.integer  "bedding",                    :limit => 4,   :default => 0,     :null => false
    t.boolean  "special_invite",                            :default => false, :null => false
  end

  add_index "participants", ["email"], :name => "email", :unique => true

  create_table "personal_contacts", :force => true do |t|
    t.string  "firstname",                                                 :null => false
    t.string  "lastname",                                                  :null => false
    t.string  "address",                                                   :null => false
    t.integer "zip_code",                    :limit => 255,                :null => false
    t.string  "email",                                                     :null => false
    t.integer "country_id",                  :limit => 255,                :null => false
    t.string  "city",                                                      :null => false
    t.integer "infopackage_contact_type_id", :limit => 11,  :default => 1, :null => false
  end

  create_table "photos", :force => true do |t|
    t.string   "image_text_en"
    t.string   "image_text_no"
    t.string   "description"
    t.string   "credits"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "original_picture_file_name"
    t.string   "original_picture_content_type"
    t.integer  "original_picture_file_size",        :limit => 11
    t.datetime "original_picture_updated_at"
    t.string   "half_article_picture_file_name"
    t.string   "half_article_picture_content_type"
    t.integer  "half_article_picture_file_size",    :limit => 11
    t.datetime "half_article_picture_updated_at"
    t.string   "full_article_picture_file_name"
    t.string   "full_article_picture_content_type"
    t.integer  "full_article_picture_file_size",    :limit => 11
    t.datetime "full_article_picture_updated_at"
  end

  create_table "positions", :force => true do |t|
    t.string  "title_en"
    t.string  "title_no"
    t.integer "person_id",      :limit => 11
    t.text    "description_en"
    t.text    "description_no"
    t.string  "group_dn"
    t.integer "admission_id",   :limit => 11
    t.integer "group_id",       :limit => 11
  end

  create_table "positions_old", :force => true do |t|
    t.text    "title_no"
    t.text    "description_no"
    t.text    "title_en"
    t.text    "description_en"
    t.boolean "deleted",                      :default => false, :null => false
    t.integer "section_id",     :limit => 11,                    :null => false
    t.string  "group_dn",                                        :null => false
    t.integer "weight",         :limit => 11, :default => 1,     :null => false
    t.integer "admission_nr",   :limit => 4,  :default => 0,     :null => false
  end

  create_table "quiz_choices", :force => true do |t|
    t.integer  "quiz_question_id", :limit => 11
    t.text     "description"
    t.integer  "points",           :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quiz_questions", :force => true do |t|
    t.integer  "quiz_id",    :limit => 11
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quiz_users", :force => true do |t|
    t.integer  "user_id",          :limit => 11
    t.integer  "quiz_question_id", :limit => 11
    t.integer  "points",           :limit => 11
    t.integer  "guesses",          :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quizzes", :force => true do |t|
    t.integer  "owner_id",    :limit => 11
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", :force => true do |t|
    t.string "name", :limit => 64, :null => false
  end

# Could not dump table "roombookings" because of following StandardError
#   Unknown type 'year(4)' for column 'year'

  create_table "rooms", :force => true do |t|
    t.string "name", :limit => 40, :null => false
  end

  create_table "sections", :force => true do |t|
    t.string "name_no"
    t.string "name_en"
  end

  create_table "spp_articles", :force => true do |t|
    t.string   "title_en"
    t.string   "title_no"
    t.text     "ingress_en"
    t.text     "ingress_no"
    t.text     "body_en"
    t.text     "body_no"
    t.boolean  "press_release"
    t.boolean  "deleted"
    t.boolean  "visible"
    t.string   "image_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "main_article"
  end

  create_table "spp_pages", :force => true do |t|
    t.string   "title_en"
    t.text     "ingress_en"
    t.text     "body_en"
    t.string   "image_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "study_places", :force => true do |t|
    t.string "name", :limit => 32, :null => false
  end

  create_table "who_am_is", :force => true do |t|
    t.integer   "guesser_id",    :limit => 11, :null => false
    t.integer   "guessed_on_id", :limit => 11, :null => false
    t.boolean   "correct",                     :null => false
    t.timestamp "created_at",                  :null => false
  end

  create_table "workshops", :force => true do |t|
    t.string "name",        :limit => 64, :null => false
    t.text   "description",               :null => false
    t.string "location",                  :null => false
  end

end
