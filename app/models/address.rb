class Address < ActiveRecord::Base
	validates_presence_of :main,:cep,:city,:district,:num
	belongs_to :city

	accepts_nested_attributes_for :city, allow_destroy: true

end
