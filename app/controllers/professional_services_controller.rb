class ProfessionalServicesController < ApplicationController
  before_action :set_professional_service, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

  # GET /professional_services
  def index
    if(params.key?(:district_id))
      @district_id = params[:district_id]
    end

    if(params.key?(:category_id))
      @category_id = params[:category_id]
    end    
  
  conditions = [:district_id, :category_id].inject({}) do |hsh, field|
    if field.blank?
      if(field == :district_id and @district_id != nil)
        hsh[field] = @district_id
      elsif(field == :category_id and @category_id != nil)
        hsh[field] = @category_id
      else
        hsh[field] = params[field]      
      end 
    end     
  end    
  
  @professional_services = ProfessionalService.where(conditions).active.find_each    
  @all_categories = Category.order :name
  @all_locations = District.order :name

  end

  # GET /professional_services/1
  def show
  end

  # GET /professional_services/new
  def new
    user_param = ActionController::Parameters.new(user_id: current_user.attributes['id'], active: true)
    user_param.permit!
    @professional_service = ProfessionalService.new(user_param)
    @city_coverages = @professional_service.city_coverages.build
    @district_coverages = @professional_service.district_coverages.build
    @serviceList = Array.new
    5.times do
      @professional_service.service_images.build
    end
  end

  # GET /professional_services/1/edit
  def edit
  end

  # POST /professional_services
  def create
    professional_service_params[:price].gsub!(/,/, '.')
    @professional_service = ProfessionalService.new(professional_service_params)
    if @professional_service.save
      redirect_to "/message/index", notice: t('helpers.messages.save', model: t('activerecord.models.professional_service.one'))
    else
      @serviceList = Service.where(:category_id => @professional_service.category_id).to_a
      5.times do
        @professional_service.service_images.build
      end
      render :new
    end
  end

  # PATCH/PUT /professional_services/1
  def update
    if @professional_service.update(professional_service_params)
      redirect_to @professional_service, notice: t('helpers.messages.update', model: t('activerecord.models.professional_service.one'))
    else
      @serviceList = Service.where(:category_id => @professional_service.category).to_a
      5.times do
        @professional_service.service_images.build
      end
      render :edit
    end
  end

  # DELETE /professional_services/1
  def destroy
    @professional_service.destroy
    redirect_to professional_services_url, notice: t('helpers.messages.delete', model: t('activerecord.models.professional_service.one'))
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_professional_service
    @professional_service = ProfessionalService.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def professional_service_params
    params.require(:professional_service).permit!
  end
  
end
