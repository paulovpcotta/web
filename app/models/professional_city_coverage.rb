class ProfessionalCityCoverage < ActiveRecord::Base
  belongs_to :professional
  belongs_to :city , :inverse_of => :professional_city_coverages
end
