class ProfessionalService < ActiveRecord::Base
  belongs_to :professional
  belongs_to :service
  belongs_to :service_unit

  validates_presence_of :service,:service_id,:service_unit_id
  accepts_nested_attributes_for :service

end
