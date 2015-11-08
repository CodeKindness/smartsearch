json.array!(@messages) do |message|
  json.extract! message, :id, :user_id, :mail_provider_id, :from, :to, :subject, :body, :originated_at
  json.url message_url(message, format: :json)
end
