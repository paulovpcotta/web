class CityCoverage < ActiveRecord::Base
  belongs_to :professional_service , :inverse_of => :city_coverages
  belongs_to :city , :inverse_of => :city_coverages
end
