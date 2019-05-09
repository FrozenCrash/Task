class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.string :image
      t.boolean :visible

      t.timestamps
    end
  end
end