module ProfessionalsHelper
  
 def list_professions
   professions = []
   @professional.professions.each do |profession|    
     professions << profession.name unless professions.include?(profession.name)
   end
   professions.to_s.gsub("[", "").gsub("\"", "").gsub("]", "")
 end
 
 def list_categories
   categories = []
   @professional.professions.each do |profession|    
       categories << profession.category.name unless categories.include?(profession.category.name)
   end
   categories.to_s.gsub("[", "").gsub("\"", "").gsub("]", "")
 end
 
end
