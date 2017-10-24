class CreateShoes < ActiveRecord::Migration
  def change
    create_table :shoes do |t|
      t.string :name
      t.float :price
      t.boolean :sold, null: false, default: false
      t.references :seller, references: :users
      t.references :buyer, references: :users

      t.timestamps null: false
    end
  end
end
