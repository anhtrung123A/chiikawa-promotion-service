class UserConsumer
  def self.start
    exchange = $channel.fanout('user.events')
    queue = $channel.queue('', durable: true)
    queue.bind(exchange)

    Rails.logger.info("UserConsumer is waiting for messages...")

    queue.subscribe(block: true) do |_delivery_info, _properties, body|
      data = JSON.parse(body)
      Rails.logger.info("Received message: #{data.inspect}")

      if data['event'] == 'user_confirmed'
        puts data
      end
    end
  end
end