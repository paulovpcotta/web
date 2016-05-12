class ProfessionalService < ActiveRecord::Base
  belongs_to :professional   

  has_one :service_unit
  has_one :service

  has_one :user, through: :professional, source: :professional_professions
  has_many :professional_profession, through: :professional, source: :professional_professions

  has_many :service_professional_feedbacks

  accepts_nested_attributes_for :service_professional_feedbacks

  validates_presence_of :active,:price, :service_id, :service_unit_id,:professional_id, :created_at, :updated_at

  scope :active, -> {where ("excluded_at IS NULL and active = TRUE")}

end
