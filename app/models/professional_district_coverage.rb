class ProfessionalDistrictCoverage < ActiveRecord::Base
  belongs_to :professional
  belongs_to :district
end
