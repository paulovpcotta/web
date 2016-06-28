json.array!(@source_feedbacks) do |source_feedback|
  json.extract! source_feedback, :id, :professional_id, :professional_profession_id, :professional_profession_service_id, :feedback_type_id
  json.url source_feedback_url(source_feedback, format: :json)
end
