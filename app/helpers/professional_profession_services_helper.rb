module ProfessionalProfessionServicesHelper
  
  require_relative '../usefull/query_creator.rb'
  parametros_clonado = {}
  
  
    def display_star_feedback(level, type_info, professional_profession_service)
      feedbacks = professional_profession_service.service_professional_feedback
      average_stars = get_average_stars(feedbacks)
      if type_info == "star"        
        choose_star_style(level, average_stars)
      else
        choose_color_star(level, average_stars)          
      end
    end 
    
    def get_name_user(user)
      user = User.find(user)
      user.first_name+" "+user.last_name              
    end
    
    def count_service_per_category(category_id)
      clause_price = get_clause_price
      
      q = QueryCreator.new()
      parametros_clonado = params.clone
      parametros_clonado[:category_id] = category_id
      joins = q.create_joins_professional_profession_service_index(parametros_clonado)    
      conditions = q.create_conditions_professional_profession_service_index(parametros_clonado)
      
      if !category_id.nil? and conditions["categories"].nil?
        conditions["categories"] = {id: category_id}       
      end
      
      joins['service'] = 'category'
        
      ProfessionalProfessionService.joins(joins)
        .where(conditions).where(clause_price).size 
    end
    
    def count_service_per_district(district_id)
      clause_price = get_clause_price
      
      q = QueryCreator.new()
      parametros_clonado = params.clone
      parametros_clonado[:district_id] = district_id
      joins = q.create_joins_professional_profession_service_index(parametros_clonado)    
      conditions = q.create_conditions_professional_profession_service_index(parametros_clonado)
      
      if !district_id.nil? and conditions["districts"].nil?
        conditions["districts"] = {id: district_id}       
      end
      
      joins_with_professional = joins['professional']
      join_districts = {}
      join_districts['professional_district_coverages'] = 'district'
      
      if !joins_with_professional.nil? and !joins_with_professional.include?(join_districts)      
        joins_with_professional << join_districts  
      end
      
        
      ProfessionalProfessionService.joins(joins)
        .where(conditions).where(clause_price).size
    end
    
    def count_service_per_kind_of_person(bol_company = nil)
      clause_price = get_clause_price
      
      q = QueryCreator.new()
      parametros_clonado = params.clone    
      joins = q.create_joins_professional_profession_service_index(parametros_clonado)    
      conditions = q.create_conditions_professional_profession_service_index(parametros_clonado)   
        
      if !bol_company.nil?
        if bol_company
          ProfessionalProfessionService.joins(joins)
          .where(conditions).where(clause_price).enterprise_service.size
        else
          ProfessionalProfessionService.joins(joins)
          .where(conditions).where(clause_price).worker_service.size
        end
      else
         ProfessionalProfessionService.joins(joins)
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
    
    
   def get_url_list_service(filtrosAtuais, ordenacoesAtuais = [])
     url = "list_service?city_name=#{@city_name}&service_name=#{@service_name}"
     if filtrosAtuais.include?("category")
       url += "#{'&category_id='+@category_id unless @category_id.blank?}"
     end
     if filtrosAtuais.include?("district")
       url += "#{'&district_id='+@district_id unless @district_id.blank?}"
     end
     if filtrosAtuais.include?("min_price")
       url += "#{'&min_price='+@min_price unless @min_price.blank?}"
     end
     if filtrosAtuais.include?("max_price")
       url += "#{'&max_price='+@max_price unless @max_price.blank?}"
     end
     if filtrosAtuais.include?("bol_company")
       url += "#{'&bol_company='+@bol_company.to_s unless @bol_company.nil?}"
     end
     
     if ordenacoesAtuais.include?("by_lower_price")
       url += "#{'&by_lower_price='+@by_lower_price.to_s unless @by_lower_price.nil?}"
     end
     url
   end
   
   private
   def choose_star_style(level, average_stars)
     if average_stars < level
          "icon-star-empty"
        else
          "icon-star"
        end
   end
   
   def choose_color_star(level, average_stars)
        if average_stars < level
          "gray"          
        else
          "gold"                  
        end
   end
   
   def get_average_stars(feedbacks)
     sum_stars = 0
     feedbacks.each do |feedback|
       sum_stars += feedback.quantity_stars
     end
     (!feedbacks.empty? and sum_stars > 0) ? (sum_stars.to_f/feedbacks.size).round : 0     
   end
  
end
