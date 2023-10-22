# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_231_022_171_624) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.bigint 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'answers', force: :cascade do |t|
    t.bigint 'question_id', null: false
    t.text 'body', null: false
    t.bigint 'author_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['author_id'], name: 'index_answers_on_author_id'
    t.index ['question_id'], name: 'index_answers_on_question_id'
  end

  create_table 'authorizations', force: :cascade do |t|
    t.string 'provider', null: false
    t.string 'uid', null: false
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.bigint 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['provider'], name: 'index_authorizations_on_provider', unique: true
    t.index ['uid'], name: 'index_authorizations_on_uid', unique: true
    t.index ['user_id'], name: 'index_authorizations_on_user_id'
  end

  create_table 'comments', force: :cascade do |t|
    t.string 'comment'
    t.bigint 'author_id', null: false
    t.string 'commentable_type', null: false
    t.bigint 'commentable_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['author_id'], name: 'index_comments_on_author_id'
    t.index %w[commentable_type commentable_id], name: 'index_comments_on_commentable'
  end

  create_table 'links', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'url', null: false
    t.string 'linkable_type', null: false
    t.bigint 'linkable_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[linkable_type linkable_id], name: 'index_links_on_linkable'
  end

  create_table 'oauth_access_grants', force: :cascade do |t|
    t.bigint 'resource_owner_id', null: false
    t.bigint 'application_id', null: false
    t.string 'token', null: false
    t.integer 'expires_in', null: false
    t.text 'redirect_uri', null: false
    t.string 'scopes', default: '', null: false
    t.datetime 'created_at', null: false
    t.datetime 'revoked_at'
    t.index ['application_id'], name: 'index_oauth_access_grants_on_application_id'
    t.index ['resource_owner_id'], name: 'index_oauth_access_grants_on_resource_owner_id'
    t.index ['token'], name: 'index_oauth_access_grants_on_token', unique: true
  end

  create_table 'oauth_access_tokens', force: :cascade do |t|
    t.bigint 'resource_owner_id'
    t.bigint 'application_id', null: false
    t.string 'token', null: false
    t.string 'refresh_token'
    t.integer 'expires_in'
    t.string 'scopes'
    t.datetime 'created_at', null: false
    t.datetime 'revoked_at'
    t.string 'previous_refresh_token', default: '', null: false
    t.index ['application_id'], name: 'index_oauth_access_tokens_on_application_id'
    t.index ['refresh_token'], name: 'index_oauth_access_tokens_on_refresh_token', unique: true
    t.index ['resource_owner_id'], name: 'index_oauth_access_tokens_on_resource_owner_id'
    t.index ['token'], name: 'index_oauth_access_tokens_on_token', unique: true
  end

  create_table 'oauth_applications', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'uid', null: false
    t.string 'secret', null: false
    t.text 'redirect_uri', null: false
    t.string 'scopes', default: '', null: false
    t.boolean 'confidential', default: true, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['uid'], name: 'index_oauth_applications_on_uid', unique: true
  end

  create_table 'questions', force: :cascade do |t|
    t.string 'title', null: false
    t.text 'body', null: false
    t.bigint 'author_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'best_answer_id'
    t.index ['author_id'], name: 'index_questions_on_author_id'
    t.index ['best_answer_id'], name: 'index_questions_on_best_answer_id'
  end

  create_table 'rewards', force: :cascade do |t|
    t.string 'name'
    t.bigint 'question_id', null: false
    t.bigint 'user_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['question_id'], name: 'index_rewards_on_question_id'
    t.index ['user_id'], name: 'index_rewards_on_user_id'
  end

  create_table 'subscriptions', force: :cascade do |t|
    t.bigint 'subscribed_question_id', null: false
    t.bigint 'subscribed_user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['subscribed_question_id'], name: 'index_subscriptions_on_subscribed_question_id'
    t.index ['subscribed_user_id'], name: 'index_subscriptions_on_subscribed_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'last_name', null: false
    t.string 'first_name', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'unconfirmed_email'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'admin', default: false
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  create_table 'votes', force: :cascade do |t|
    t.string 'body'
    t.bigint 'author_id', null: false
    t.string 'votable_type', null: false
    t.bigint 'votable_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['author_id'], name: 'index_votes_on_author_id'
    t.index %w[votable_type votable_id], name: 'index_votes_on_votable'
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'answers', 'questions'
  add_foreign_key 'answers', 'users', column: 'author_id'
  add_foreign_key 'authorizations', 'users'
  add_foreign_key 'comments', 'users', column: 'author_id'
  add_foreign_key 'oauth_access_grants', 'oauth_applications', column: 'application_id'
  add_foreign_key 'oauth_access_tokens', 'oauth_applications', column: 'application_id'
  add_foreign_key 'questions', 'users', column: 'author_id'
  add_foreign_key 'rewards', 'questions'
  add_foreign_key 'subscriptions', 'questions', column: 'subscribed_question_id'
  add_foreign_key 'subscriptions', 'users', column: 'subscribed_user_id'
  add_foreign_key 'votes', 'users', column: 'author_id'
end
