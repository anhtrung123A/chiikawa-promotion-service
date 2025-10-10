class CreatePromotions < ActiveRecord::Migration[8.0]
  def change
    create_table :promotions do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :value
      t.string :description
      t.string :code
      t.boolean :is_used, default: false

      t.timestamps
    end
    add_index :promotions, :code, unique: true
  end
end
