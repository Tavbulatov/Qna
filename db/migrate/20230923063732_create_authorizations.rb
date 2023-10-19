# frozen_string_literal: true

class CreateAuthorizations < ActiveRecord::Migration[6.1]
  def change
    create_table :authorizations do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :authorizations, :provider, unique: true
    add_index :authorizations, :uid, unique: true
  end
end
