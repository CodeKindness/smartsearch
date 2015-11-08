json.array!(@contacts) do |contact|
  json.extract! contact, :id, :user_id, :email, :company_id, :position, :first_name, :last_name
  json.url contact_url(contact, format: :json)
end
