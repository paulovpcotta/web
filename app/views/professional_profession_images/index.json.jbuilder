json.array!(@professional_profession_images) do |professional_profession_image|
  json.extract! professional_profession_image, :id
  json.url professional_profession_image_url(professional_profession_image, format: :json)
end
