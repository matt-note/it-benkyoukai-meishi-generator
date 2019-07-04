class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :login, null: false
      t.string :name, null: false
      t.string :twitter_account, null: false

      t.timestamps
    end
  end
end
