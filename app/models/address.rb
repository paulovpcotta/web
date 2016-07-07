class Address < ActiveRecord::Base

  belongs_to :city
	attr_accessor :state_id


	validates_presence_of :main,:cep,:city_id,:state_id,:district

end
