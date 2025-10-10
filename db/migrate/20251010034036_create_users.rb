class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :full_name
      t.string :line_user_id
      t.integer :month_of_birth

      t.timestamps
    end
  end
end
