class Professional < ActiveRecord::Base
  # has_one :address
  # has_one :phone
  # belongs_to :user

  # has_many :professional_district_coverages
  # has_many :professional_city_coverages
  # has_many :professional_services
  has_many :professional_professions

  # has_many :service_professional_feedbacks, through: :users
  # has_many :professional_profession_images, through: :professional_professions

  # has_and_belongs_to_many :services
  # has_and_belongs_to_many :districts
  # has_and_belongs_to_many :cities
  # has_and_belongs_to_many :professions

  # accepts_nested_attributes_for :address, allow_destroy: true
  # accepts_nested_attributes_for :phone, allow_destroy: true

  validates_presence_of :active,:user_id, :nothing_on_record, :phone_id, :address_id, :created_at, :updated_at

  scope :active, -> {where ("active = TRUE")}
end
