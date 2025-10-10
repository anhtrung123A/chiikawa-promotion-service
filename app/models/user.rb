class User < ApplicationRecord
  has_many :promotions
  
  def self.reset_has_received_promotion_this_year
    update_all(has_received_promotion_this_year: false)
  end
end
