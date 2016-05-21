module ProfessionalServicesHelper

public
  def count_service_per_category(category_id)
    clause_price = "";
    
    if !@max_price.nil? and !@max_price.blank?
      clause_price = "price between #{@min_price} and #{@max_price}"      
    end
      
    if !@district_id.nil? 
      ProfessionalService.joins(service: :category, professional: {professional_district_coverages: :district})
      .where(categories: {id: category_id}, districts: {id: @district_id}).where(clause_price).size
    else
      ProfessionalService.joins(service: :category).where(categories: {id: category_id}).where(clause_price).size    
    end    
  end

end
