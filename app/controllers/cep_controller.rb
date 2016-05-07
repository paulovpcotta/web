class CepController < ApplicationController

  require 'correios-cep'



  def search

    addressFound = Correios::CEP::AddressFinder.get(params[:id])

  	@address = Address.new
    @address.main =  addressFound[:address]
    @address.district =  addressFound[:neighborhood]
    @address.city =  City.find_by_name addressFound[:city]
    @address.cep  = params[:id]
    respond_to do |format|
  		format.json { render json: @address }
	  end
  end
end
