json.array!(@professional_services) do |professional_service|
  json.extract! professional_service, :id, :title, :description, :active, :price, :service_id, :user_id
  json.url professional_service_url(professional_service, format: :json)
end
