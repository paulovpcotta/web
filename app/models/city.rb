class City < ActiveRecord::Base

  belongs_to :state
  accepts_nested_attributes_for :state, allow_destroy: true

  has_many :professional_city_coverages, :inverse_of => :cities

  has_and_belongs_to_many :professionals

  validates_presence_of :state
end
