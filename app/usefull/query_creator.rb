class QueryCreator
  
  def create_joins_professional_profession_service_index(params)
    joins = {}
    joins_with_professional = []
    join_users = {}    
    join_cities = {}    
    
    joins_with_professional << :user   
       
    if(params.key?(:district_id) and !params[:district_id].blank?)      
      join_districts = {}
      join_districts['professional_district_coverages'] = 'district'
      joins_with_professional << join_districts      
    end
          
    if(params.key?(:category_id) and !params[:category_id].blank?)
      joins['service'] = 'category'          
    end
    joins['professional'] = joins_with_professional
    joins['professional_profession'] = 'profession'
    joins
  end
  
  def create_conditions_professional_profession_service_index(params)
    conditions = ['districts', 'categories'].inject({}) do |hash, field|
    if !field.blank?
      if(field == 'districts' and params.key?(:district_id) and !params[:district_id].blank?)
        hash[field] = {id: params[:district_id]}        
      elsif(field == 'categories' and params.key?(:category_id) and !params[:category_id].blank?)
        hash[field] = {id: params[:category_id]}        
      end
      hash 
    end
    end
    conditions
  end  
  
end