

class ProfessionalsController < ApplicationController

  require 'correios-cep'

  before_action :set_professional, only: [:show, :edit, :update, :destroy]

  # GET /professionals
  def index
    @professionals = Professional.all
  end

  # GET /professionals/1
  def show
  end

  # GET /professionals/new
  def new
    @professional = Professional.new
    @professional.address = Address.new
    @professional.address.city = City.new
    @city_list = {}
  end

  # GET /professionals/1/edit
  def edit
  end

  # POST /professionals
  def create
    @professional = Professional.new(professional_params)
    if @professional.save
      redirect_to @professional, notice: t('helpers.messages.save' , model:t('activerecord.models.professional.one'))
    else
      render :new
    end
  end

  def search

    addressFound = Correios::CEP::AddressFinder.get(params[:id])

    @address = Address.new
    @address.main =  addressFound[:address]
    @address.district =  addressFound[:neighborhood]
    @address.city =  City.find_by_name addressFound[:city]
    @address.cep  = params[:id]
    @city_list = City.find_by_state_id @address.city.state_id
    @professional = Professional.new
    @professional.address = @address
    respond_to do |format|
      format.js
    end
  end

  # PATCH/PUT /professionals/1
  def update
    if @professional.update(professional_params)
      redirect_to @professional, notice: t('helpers.messages.update' , model:t('activerecord.models.professional.one'))
    else
      render :edit
    end
  end

  # DELETE /professionals/1
  def destroy
    @professional.destroy
    redirect_to professionals_url, notice: t('helpers.messages.delete' , model:t('activerecord.models.professional.one'))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_professional
      @professional = Professional.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def professional_params
      params.require(:professional).permit!
    end

end

