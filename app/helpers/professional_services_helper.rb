module ProfessionalServicesHelper

public
  def count_service_per_category(category_id, district_id=nil)
    if !district_id.nil?
      ProfessionalService.joins(service: :category, professional: {professional_district_coverages: :district})
      .where(categories: {id: category_id}, districts: {id: district_id}).size
    else
      ProfessionalService.joins(service: :category).where(categories: {id: category_id}).size    
    end
    
  end

end
