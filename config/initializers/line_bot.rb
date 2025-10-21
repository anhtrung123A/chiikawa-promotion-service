require 'line/bot'

$line_client ||= Line::Bot::V2::MessagingApi::ApiClient.new(
    channel_access_token: ENV["LINE_CHANNEL_ACCESS_TOKEN"]
)
