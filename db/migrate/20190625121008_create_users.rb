# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name
      t.string :login, null: false
      t.string :twitter_account, null: false

      t.timestamps
    end
  end
end
