class ProfessionalCityCoverage < ActiveRecord::Base
  belongs_to :professional
  belongs_to :city

  validates_presence_of :city_id
end
