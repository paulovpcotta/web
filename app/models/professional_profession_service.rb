class ProfessionalProfessionService < ActiveRecord::Base
  belongs_to :service_unit
  belongs_to :service

  belongs_to :professional_profession

  has_one :professional, through: :professional_profession
  has_one :user, through: :professional
  has_one :profile, through: :user
  
  has_many :profession, through: :professional_profession
  has_many :source_feedbacks, through: :professional_profession

  #accepts_nested_attributes_for :service

  attr_accessor :category_id

  validates_presence_of :active,:price,:service_unit,:service

  scope :active, -> {where ("excluded_at IS NULL and professional_profession_services.active = TRUE")}
  
  scope :enterprise_service, -> {where ("char_length(users.cpf) > 11")}
  
  scope :worker_service, -> {where ("char_length(users.cpf) <= 11")}
end
