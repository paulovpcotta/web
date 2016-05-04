class DistrictCoverage < ActiveRecord::Base
  belongs_to :professional_service
  belongs_to :district
end
