class LinePushService
  def self.push_text(user_id, text)
    message = Line::Bot::V2::MessagingApi::TextMessage.new(text: text)
    request = Line::Bot::V2::MessagingApi::PushMessageRequest.new(
      to: user_id,
      messages: [message]
    )

    $line_client.push_message(push_message_request: request)
  rescue => e
    Rails.logger.error("LINE push error: #{e.message}")
    nil
  end
end
