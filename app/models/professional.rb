class Professional < ActiveRecord::Base
  belongs_to :address
  belongs_to :phone
  belongs_to :user

  has_many :professional_district_coverages
  has_many :professional_city_coverages
  has_many :professional_professions
  has_many :districts, through: :professional_district_coverages
  
  # has_many :service_professional_feedbacks, through: :users
  # has_many :professional_profession_images, through: :professional_professions

  # has_and_belongs_to_many :services
  
  has_and_belongs_to_many :cities
  has_many :professions, through: :professional_professions

  accepts_nested_attributes_for :address, allow_destroy: true
  accepts_nested_attributes_for :phone, allow_destroy: true
  accepts_nested_attributes_for :professional_professions, allow_destroy: true
  accepts_nested_attributes_for :professional_district_coverages, allow_destroy: true
  accepts_nested_attributes_for :professional_city_coverages, allow_destroy: true
  accepts_nested_attributes_for :districts, allow_destroy: true

  validates_presence_of :active,:user_id, :address, :phone

  scope :active, -> {where ("active = TRUE")}
end
