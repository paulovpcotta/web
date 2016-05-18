class Service < ActiveRecord::Base
  has_one :category

  has_and_belongs_to_many :professionals
end
