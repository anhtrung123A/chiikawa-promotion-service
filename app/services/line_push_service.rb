class LinePushService
  def self.push_text(user_id, text)
    message = Line::Bot::V2::MessagingApi::TextMessage.new(text: text)
    request = Line::Bot::V2::MessagingApi::PushMessageRequest.new(
      to: user_id,
      messages: [ message ]
    )

    $line_client.push_message(push_message_request: request)
  rescue => e
    Rails.logger.error("LINE push error: #{e.message}")
    nil
  end

  def self.push_promotion(promotion)
    target_user = promotion.user
    message = Line::Bot::V2::MessagingApi::FlexMessage.new(
      alt_text: "お誕生日月おめでとうございます！🎉",
      contents: {
        type: "bubble",

        # Hero section with birthday image
        hero: {
          type: "image",
          url: "https://res.cloudinary.com/dcmasdlec/image/upload/v1760160889/473706715_17894186328120397_3758273317179282933_n_h1txbz.jpg",
          size: "full",
          aspect_ratio: "4:3",
          aspect_mode: "cover"
        },

        # Body with birthday month message and promotion code
        body: {
          type: "box",
          layout: "vertical",
          spacing: "md",
          contents: [
            { type: "text", text: "🎂 #{target_user.full_name}さん、今月はお誕生日月です！", weight: "bold", size: "md", wrap: true },
            { type: "text", text: "素敵な1か月になりますように！🎁", size: "sm", color: "#555555", wrap: true },
            {
              type: "text",
              text: "あなたのプロモーションコードは ",
              size: "sm",
              wrap: true,
              contents: [
                { type: "span", text: promotion.code, weight: "bold" },
                { type: "span", text: " です。購入時に " },
                { type: "span", text: "#{promotion.value}%", weight: "bold" },
                { type: "span", text: " の割引が適用されます。" }
              ]
            }
          ]
        },

        # Footer with button
        footer: {
          type: "box",
          layout: "vertical",
          spacing: "sm",
          contents: [
            {
              type: "button",
              style: "primary",
              color: "#FF6666",
              action: {
                type: "uri",
                label: "割引を利用する 🎁",
                uri: "https://example.com/birthday-gift"
              }
            }
          ]
        }
      }
    )

    $line_client.push_message(
      push_message_request: Line::Bot::V2::MessagingApi::PushMessageRequest.new(
        to: target_user.line_user_id,
        messages: [ message ]
      )
    )
  end
end
