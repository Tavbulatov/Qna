# frozen_string_literal: true

class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.references :subscribed_question, null: false, foreign_key: { to_table: :questions }
      t.references :subscribed_user, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
