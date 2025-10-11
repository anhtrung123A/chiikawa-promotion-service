# app/jobs/birthday_promotion_job.rb
class BirthdayPromotionJob < ApplicationJob
  queue_as :default

  def perform(promotion)
    LinePushService.push_promotion(promotion)
  rescue => e
    Rails.logger.error("Failed to send birthday promotion to user #{user_id}: #{e.message}")
  end
end
