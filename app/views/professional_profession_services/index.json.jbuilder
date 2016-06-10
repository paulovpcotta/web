json.array!(@professional_profession_services) do |professional_profession_service|
  json.extract! professional_profession_service, :id, :professional_profession_id, :service_id, :service_unit_id, :price, :active, :excluded_at
  json.url professional_profession_service_url(professional_profession_service, format: :json)
end
