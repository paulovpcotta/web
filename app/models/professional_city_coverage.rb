class ProfessionalCityCoverage < ActiveRecord::Base
  belongs_to :professional
  belongs_to :city
end
