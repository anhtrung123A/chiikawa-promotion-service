class StripePromotionManager
  def self.create_promotion(code)
    coupon = Stripe::Coupon.create(
      percent_off: 40,
      duration: 'once',
      redeem_by: Date.today.end_of_month.end_of_day.to_time.to_i,
      max_redemptions: 1,
      currency: "JPY"
    )

    promo = Stripe::PromotionCode.create(
      promotion: {
        type: 'coupon',
        coupon: coupon.id
      },
      code: code,
      active: true,
      expires_at: coupon.redeem_by
    )
  end

  def self.test_checkout(promo_code:, items:)
    promo = Stripe::PromotionCode.list(code: promo_code, active: true).data.first
    raise "Invalid or expired promo code" if promo.nil?

    line_items = items.map do |item|
      {
        price_data: {
          currency: 'jpy',
          product_data: { 
            name: item[:name],
            images: [
            'https://chiikawamarket.jp/cdn/shop/files/4526371152965_1.jpg'
            ]
          },
          unit_amount: item[:amount]
        },
        quantity: item[:quantity]
      }
    end

    session = Stripe::Checkout::Session.create(
      mode: 'payment',
      line_items: line_items,
      discounts: [{ promotion_code: promo.id }],
      success_url: 'https://google.com?success=true',
      cancel_url: 'https://google.com?canceled=true'
    )

    puts "Checkout URL: #{session.url}"
    session.url
  end
end
