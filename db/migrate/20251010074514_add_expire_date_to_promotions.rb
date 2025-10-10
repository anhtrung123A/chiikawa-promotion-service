class AddExpireDateToPromotions < ActiveRecord::Migration[8.0]
  def change
    add_column :promotions, :expire_date, :datetime
  end
end
