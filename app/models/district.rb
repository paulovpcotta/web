class District < ActiveRecord::Base
  belongs_to :city
  has_many :professionals, through: :professional_district_coverages
end
