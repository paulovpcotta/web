module ProfessionalServicesHelper

public
  def count_service_per_category(category_id)
    Service.where(category_id: category_id).size
  end

end
