class AddHasReceivedPromotionThisYearToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :has_received_promotion_this_year, :boolean, default: false
  end
end
