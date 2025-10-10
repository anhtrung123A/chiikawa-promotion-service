class UserConsumer
  def self.start
    exchange = $channel.fanout('user.events')
    queue = $channel.queue('', durable: true)
    queue.bind(exchange)

    Rails.logger.info("UserConsumer is waiting for messages...")

    queue.subscribe(block: true) do |_delivery_info, _properties, body|
      data = JSON.parse(body)
      Rails.logger.info("Received message: #{data.inspect}")

      case data['event']
      when 'user_confirmed'
        user = User.new(
          id: data["id"],
          email: data["email"],
          line_user_id: data["line_user_id"],
          month_of_birth: Date.parse(data["dob"]).month,
          full_name: data["full_name"]
        )
        user.save

      when 'user_updated'
        user = User.find_by(id: data["id"])
        if user
          user.update(
            email: data["email"],
            line_user_id: data["line_user_id"],
            month_of_birth: Date.parse(data["dob"]).month,
            full_name: data["full_name"]
          )
        end

      when 'user_deleted'
        user = User.find_by(id: data["id"])
        user&.destroy
      end
    end
  end
end