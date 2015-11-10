json.array! @companies do |company|
  json.value company.id
  json.text company.name
end
