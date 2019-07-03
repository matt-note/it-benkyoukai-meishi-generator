class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :login, null: false
      t.string :name
      t.string :twitter_name

      t.timestamps
    end
  end
end
