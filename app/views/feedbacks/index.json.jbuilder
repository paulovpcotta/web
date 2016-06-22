json.array!(@feedbacks) do |feedback|
  json.extract! feedback, :id, :quantity_stars, :source_feedback_id, :user_id, :user_opnion, :active
  json.url feedback_url(feedback, format: :json)
end
