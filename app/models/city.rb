class City < ActiveRecord::Base

  belongs_to :state
  accepts_nested_attributes_for :state, allow_destroy: true

  has_many :city_coverages
end
