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

ActiveRecord::Schema.define(version: 20_170_925_234_753) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'
  enable_extension 'cube'
  enable_extension 'earthdistance'

  create_table 'auth_tokens', force: :cascade do |t|
    t.string 'value'
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'expired_at'
    t.index ['user_id'], name: 'index_auth_tokens_on_user_id'
    t.index ['value'], name: 'index_auth_tokens_on_value', unique: true
  end

  create_table 'events', force: :cascade do |t|
    t.bigint 'place_id'
    t.bigint 'user_id'
    t.integer 'kind', default: 0
    t.string 'title'
    t.text 'description'
    t.datetime 'start_time'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['place_id'], name: 'index_events_on_place_id'
    t.index ['user_id'], name: 'index_events_on_user_id'
  end

  create_table 'invites', force: :cascade do |t|
    t.bigint 'event_id'
    t.bigint 'user_id'
    t.integer 'respond', default: 0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['event_id'], name: 'index_invites_on_event_id'
    t.index %w[user_id event_id], name: 'index_invites_on_user_id_and_event_id', unique: true
    t.index ['user_id'], name: 'index_invites_on_user_id'
  end

  create_table 'place_users', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'place_id'
    t.integer 'rating'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.text 'review'
    t.index ['place_id'], name: 'index_place_users_on_place_id'
    t.index %w[user_id place_id], name: 'index_place_users_on_user_id_and_place_id', unique: true
    t.index ['user_id'], name: 'index_place_users_on_user_id'
  end

  create_table 'places', force: :cascade do |t|
    t.string 'name'
    t.string 'city'
    t.string 'tags', default: [], array: true
    t.float 'lat'
    t.float 'lng'
    t.decimal 'overall_rating', precision: 3, scale: 2
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'place_id'
    t.index 'll_to_earth(lat, lng)', name: 'places_earthdistance_ix', using: :gist
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email'
    t.string 'password_digest'
    t.string 'first_name'
    t.string 'last_name'
    t.datetime 'birthday'
    t.integer 'gender', default: 0
    t.float 'lat'
    t.float 'lng'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'avatar_file_name'
    t.string 'avatar_content_type'
    t.integer 'avatar_file_size'
    t.datetime 'avatar_updated_at'
  end

  add_foreign_key 'auth_tokens', 'users'
  add_foreign_key 'events', 'places'
  add_foreign_key 'events', 'users'
  add_foreign_key 'invites', 'events'
  add_foreign_key 'invites', 'users'
  add_foreign_key 'place_users', 'places'
  add_foreign_key 'place_users', 'users'
end
