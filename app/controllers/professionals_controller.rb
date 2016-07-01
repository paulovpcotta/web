class ProfessionalsController < ApplicationController

  require 'correios-cep'
  before_filter :authenticate_user!, only: [:new]

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
    @professional.user_id = current_user.id
    @professional.active = true
    @professional.address = Address.new
    #@professional.address.city = City.new
    @professional.phone = Phone.new
    @professional.professional_professions.build
    @professional.professional_city_coverages.build
    @professional.professional_district_coverages.build
    @professional.districts.build
    @professional_service = ProfessionalProfessionService.new
    @services = {}
    @city_list = {}
    session[:professional] = @professional
  end

  # GET /professional/professional_services/new
  def new_professional_services
    @professional = Professional.new(session[:professional])
    @professional_service = ProfessionalProfessionService.new
    @professional_service.professional_profession_id = params[:professional_profession_id]
    @professional_service.service = Service.new
    @professional_service.active = true
    @services = {}
    respond_to do |format|
      format.js
    end
  end

  def update_services
    serviceList = Service.where(:category_id => params[:category_id])
    @services = serviceList.map { |a| [a.name, a.id] }.insert(0, "Selecione")
    respond_to do |format|
      format.js
    end
  end

  def update_city_list
    cityList = City.where(:state_id => params[:state_id])
    @city_list = cityList.map { |a| [a.name, a.id] }.insert(0, "Selecione")
    respond_to do |format|
      format.js
    end
  end

  # POST /professional_services
  def create_professional_services
    professional_service_params[:price].gsub!(',', '.')
    if (professional_service_params[:id].empty?)
      @professional_service = ProfessionalProfessionService.new(professional_service_params)
      if @professional_service.save
        @professional_service_list = ProfessionalProfessionService.where(:professional_profession_id => @professional_service.professional_profession_id)
        respond_to do |format|
          format.js
        end
      else
        @professional_service_list = {}
        render :new_part2
      end
    else
      @professional_service = ProfessionalProfessionService.find professional_service_params[:id]
      if @professional_service.update(professional_service_params)
        @professional_service_list = ProfessionalProfessionService.where(:professional_profession_id => @professional_service.professional_profession_id)
        respond_to do |format|
          format.js
        end
      else
        @professional_service.errors
        @professional_service_list = {}
        render :new_part2
      end
    end
  end

  # GET /professional_services/1/edit
  def edit_professional_services
    @professional = Professional.new(session[:professional])
    @professional_service = ProfessionalProfessionService.find params[:id]
    @professional_service.category_id = @professional_service.service.category_id
    @services = Service.where(:category_id => @professional_service.category_id)
    respond_to do |format|
      format.js
    end
  end

  # GET /professional_services/1/edit
  def delete_professional_services
    @professional_service = ProfessionalProfessionService.find params[:id]
    @professional_service.delete
    @professional_service_list = ProfessionalProfessionService.where(:professional_profession_id => @professional_service.professional_profession_id)
    respond_to do |format|
      format.js
    end
  end

  # GET /professionals/1/edit
  def edit
  end

  # POST /professionals
  def create
    @professional = Professional.new(professional_params)
    if @professional.save
      @professional_service = ProfessionalProfessionService.new
      @professional_service.service = Service.new
      @professional_service.active = true
      @professional_service.professional_profession_id = @professional.professional_professions.first.id
      @professional_service_list = {}
      @services = {}
      render :new_part2
    else
      @city_list = {}
      if (@professional.address.state_id.present?)
        @city_list = City.where(:state_id => @professional.address.state_id)
      end
      render :new
    end
  end

  def city_coverage_search
     @district_coverage_list = District.where(city_id: params[:id])
      respond_to do |format|
        format.js
      end
  end

  def search

    addressFound = Correios::CEP::AddressFinder.get(params[:id])

    @address = Address.new
    @address.main = addressFound[:address]
    @address.district = addressFound[:neighborhood]
    city = City.find_by_name addressFound[:city]
    @address.city_id = city.id
    @address.state_id = city.state_id
    @address.cep = params[:id]
    @city_list = City.where(:state_id => city.state_id)
    @professional = Professional.new
    @professional.address = @address
    respond_to do |format|
      format.js
    end
  end

  # PATCH/PUT /professionals/1
  def update
    if @professional.update(professional_params)
      redirect_to @professional, notice: t('helpers.messages.update', model: t('activerecord.models.professional.one'))
    else
      render :edit
    end
  end

  # DELETE /professionals/1
  def destroy
    @professional.destroy
    redirect_to professionals_url, notice: t('helpers.messages.delete', model: t('activerecord.models.professional.one'))
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

  # Only allow a trusted parameter "white list" through.
  def professional_service_params
    params.require(:professional_profession_service).permit!
  end

end

