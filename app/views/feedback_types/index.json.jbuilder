json.array!(@feedback_types) do |feedback_type|
  json.extract! feedback_type, :id, :name, :description, :active
  json.url feedback_type_url(feedback_type, format: :json)
end
