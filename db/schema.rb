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

ActiveRecord::Schema.define(version: 20151114225346) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string   "slug"
    t.integer  "user_id"
    t.integer  "order"
    t.integer  "rating"
    t.string   "name"
    t.string   "address"
    t.string   "website_url"
    t.string   "linkedin_url"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.boolean  "auto_assigns",       default: false
    t.integer  "primary_contact_id"
  end
  add_index "companies", ["primary_contact_id"], name: "index_companies_on_primary_contact_id", using: :btree

  create_table "companies_contacts", id: false, force: :cascade do |t|
    t.integer "company_id", null: false
    t.integer "contact_id", null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.integer  "contact_id"
    t.integer  "event_type_id"
    t.text     "description"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "slug"
  end
  add_index "events", ["event_type_id"], name: "index_events_on_event_type_id", using: :btree
  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "mail_provider_id"
    t.string   "from"
    t.string   "to"
    t.string   "subject"
    t.text     "body"
    t.datetime "originated_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "read_at"
    t.string   "slug"
    t.string   "cc"
    t.string   "workflow_state"
    t.integer  "contact_id"
    t.integer  "company_id"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
  end
  add_index "messages", ["company_id"], name: "index_messages_on_company_id", using: :btree
  add_index "messages", ["depth"], name: "index_messages_on_depth", using: :btree
  add_index "messages", ["lft"], name: "index_messages_on_lft", using: :btree
  add_index "messages", ["parent_id"], name: "index_messages_on_parent_id", using: :btree
  add_index "messages", ["rgt"], name: "index_messages_on_rgt", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_view "company_activities", <<-'END_VIEW_COMPANY_ACTIVITIES', :force => true
SELECT u.user_id,
    u.company_id,
    companies.name,
    count(*) AS aggregate_count,
    ((count(*))::double precision / (date_part('day'::text, age(now(), (companies.created_at)::timestamp with time zone)) + (1)::double precision)) AS activity
   FROM (( SELECT events.user_id,
            events.company_id,
            events.created_at
           FROM events
        UNION
         SELECT messages.user_id,
            messages.company_id,
            messages.created_at
           FROM messages) u
     LEFT JOIN companies ON ((companies.id = u.company_id)))
  WHERE (u.company_id IS NOT NULL)
  GROUP BY u.user_id, u.company_id, companies.name, companies.created_at
  END_VIEW_COMPANY_ACTIVITIES

  create_table "event_types", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "highlight_color"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "order"
  end
  add_index "event_types", ["order"], name: "index_event_types_on_order", using: :btree

  create_view "user_aggregates", <<-'END_VIEW_USER_AGGREGATES', :force => true
SELECT u.user_id,
    u.company_id,
    u.contact_id,
    u.aggregateable_id,
    u.aggregateable_type,
    u.slug,
    u.created_at,
    u.start_at,
    u.end_at,
    u.read_at,
    u.event_type,
    u.highlight_color,
    u.description,
    u.workflow_state
   FROM ( SELECT events.user_id,
            events.company_id,
            events.contact_id,
            events.id AS aggregateable_id,
            'Event'::text AS aggregateable_type,
            events.slug,
            events.created_at,
            events.start_at,
            events.end_at,
            NULL::timestamp without time zone AS read_at,
            event_types.name AS event_type,
            event_types.highlight_color,
            events.description,
            NULL::character varying AS workflow_state
           FROM (events
             LEFT JOIN event_types ON ((event_types.id = events.event_type_id)))
        UNION
         SELECT messages.user_id,
            messages.company_id,
            messages.contact_id,
            messages.id AS aggregateable_id,
            'Message'::text AS aggregateable_type,
            messages.slug,
            messages.created_at,
            messages.originated_at AS start_at,
            NULL::timestamp without time zone AS end_at,
            messages.read_at,
            'Message'::character varying AS event_type,
            NULL::character varying AS highlight_color,
            messages.subject AS description,
            messages.workflow_state
           FROM messages) u
  ORDER BY u.start_at DESC
  END_VIEW_USER_AGGREGATES

  create_view "company_progresses", <<-'END_VIEW_COMPANY_PROGRESSES', :force => true
SELECT companies.id,
    companies.user_id,
    companies.slug,
    companies.name,
    COALESCE(user_aggregates.event_type, 'Pending'::character varying) AS event_type,
    count(user_aggregates.event_type) AS count
   FROM (companies
     LEFT JOIN user_aggregates ON ((user_aggregates.company_id = companies.id)))
  GROUP BY user_aggregates.event_type, companies.name, companies.id
  END_VIEW_COMPANY_PROGRESSES

  create_table "contacts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "email"
    t.integer  "company_id"
    t.string   "position"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "slug"
    t.string   "phone_number"
    t.string   "linkedin_url"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           null: false
    t.integer  "sluggable_id",   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end
  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "name"
    t.integer  "role"
    t.string   "nickname"
    t.string   "time_zone"
  end
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
