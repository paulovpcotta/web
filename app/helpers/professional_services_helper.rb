module ProfessionalServicesHelper

require_relative '../usefull/query_creator.rb'
parametros_clonado = {}

public
  def count_service_per_category(category_id)
    clause_price = get_clause_price
    
    q = QueryCreator.new()
    parametros_clonado = params.clone
    parametros_clonado[:category_id] = category_id
    joins = q.create_joins_professional_service_index(parametros_clonado)    
    conditions = q.create_conditions_professional_service_index(parametros_clonado)
    
    if !category_id.nil? and conditions["categories"].nil?
      conditions["categories"] = {id: category_id}       
    end
    
    joins['service'] = 'category'
      
    ProfessionalService.joins(joins)
      .where(conditions).where(clause_price).size 
  end
  
  def count_service_per_district(district_id)
    clause_price = get_clause_price
    
    q = QueryCreator.new()
    parametros_clonado = params.clone
    parametros_clonado[:district_id] = district_id
    joins = q.create_joins_professional_service_index(parametros_clonado)    
    conditions = q.create_conditions_professional_service_index(parametros_clonado)
    
    if !district_id.nil? and conditions["districts"].nil?
      conditions["districts"] = {id: district_id}       
    end
    
    joins_with_professional = joins['professional']
    join_districts = {}
    join_districts['professional_district_coverages'] = 'district'
    
    if !joins_with_professional.nil? and !joins_with_professional.include?(join_districts)      
      joins_with_professional << join_districts  
    end
    
      
    ProfessionalService.joins(joins)
      .where(conditions).where(clause_price).size
  end
  
  def count_service_per_kind_of_person(bol_company = nil)
    clause_price = get_clause_price
    
    q = QueryCreator.new()
    parametros_clonado = params.clone    
    joins = q.create_joins_professional_service_index(parametros_clonado)    
    conditions = q.create_conditions_professional_service_index(parametros_clonado)   
      
    if !bol_company.nil?
      if bol_company
        ProfessionalService.joins(joins)
        .where(conditions).where(clause_price).enterprise_service.size
      else
        ProfessionalService.joins(joins)
        .where(conditions).where(clause_price).worker_service.size
      end
    else
       ProfessionalService.joins(joins)
        .where(conditions).where(clause_price).size 
    end     
         
  end
  
  def get_clause_price
    clause_price = ""
    
    if !@max_price.nil? and !@max_price.blank? and !@min_price.nil? and !@min_price.blank?
      clause_price = "price between #{@min_price} and #{@max_price}"       
    end
    clause_price
  end

end
