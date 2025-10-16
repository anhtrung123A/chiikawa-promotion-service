class PromotionConsumer
  EXCHANGE_NAME = "promotion.events"

  def self.start
    exchange = $channel.direct(EXCHANGE_NAME)

    queue = $channel.queue("promotion_service_queue", durable: true)

    queue.bind(exchange, routing_key: "promotion.used")

    puts "PromotionConsumer is waiting for messages..."

    queue.subscribe(block: true) do |_delivery_info, _properties, body|
      data = JSON.parse(body)
      event = data["event"]

      case event
      when "used"
        promotion = Promotion.where(code: data["promotion_code"]).first
        promotion.update(is_used: true) if promotion != nil
      else
        puts "Unknown event: #{event}"
      end
    end
  end
end
