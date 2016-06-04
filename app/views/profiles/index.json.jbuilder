json.array!(@profiles) do |profile|
  json.extract! profile, :id, :photo_content
  json.url profile_url(profile, format: :json)
end
