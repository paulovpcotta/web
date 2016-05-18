class Professional < ActiveRecord::Base
  belongs_to :address

  has_many :professional_services, :dependent => :destroy
  has_many :city_coverages, :dependent => :destroy
  has_many :cities, through: :city_coverages
  has_many :district_coverages, :dependent => :destroy
  has_many :districts, through: :district_coverages

  accepts_nested_attributes_for :city_coverages
  accepts_nested_attributes_for :district_coverages
  accepts_nested_attributes_for :professional_services


  accepts_nested_attributes_for :address, allow_destroy: true
end
