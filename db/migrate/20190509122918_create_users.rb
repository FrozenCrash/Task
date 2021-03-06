class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :email
      t.string :password_hash
      t.boolean :admin

      t.timestamps
    end
  end
end
