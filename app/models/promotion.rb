class Promotion < ApplicationRecord
  belongs_to :user

  def self.distribute_promotions_to_users_who_have_birthday_in_this_month
    this_month = Time.now.month
    users = User.where("month_of_birth = :month_of_birth AND has_received_promotion_this_year = :has_received_promotion_this_year",
           month_of_birth: this_month, has_received_promotion_this_year: false)
    users_data = users.map do |user|
    {
      user_id: user.id,
      description: "Special promotion for you only, please enter to get wonderful discount on total payment!",
      value: 40,
      code: "CHIIKAWA-#{SecureRandom.hex(4)}",
      expire_date: Time.current + 30.days
    }
    end
    result = insert_all(users_data, returning: %w[id])
    ids = result.rows.map { |row| row.first }
    new_promotions = Promotion.where(id: ids)
    new_promotions.each do |promotion|
      BirthdayPromotionJob.perform_later(promotion)
    end
    users.update_all(has_received_promotion_this_year: true)
  end

  def is_expired
    expire_date < Time.now
  end
end
