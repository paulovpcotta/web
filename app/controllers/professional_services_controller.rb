class ProfessionalServicesController < ApplicationController
  before_action :set_professional_service, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

  def load_combos_boxes
    @all_categories = Category.order :name
    @all_locations = District.order :name    
  end  

  # GET /professional_services
  def index
    load_combos_boxes
    
    @professional_services = nil
    @min_price = params[:min_price]
    @max_price = params[:max_price]
    @city_name = ""
    @distric_id = nil
    @category_id = nil
    @service_name = ""    
    
    joins = create_joins    
    clause_search_bar = get_clause_search_bar    
    conditions = create_conditions
    search_index(joins, clause_search_bar, conditions)
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
  
  def get_clause_search_bar
      clause_search_bar = "cities.name like \'#{@city_name}%\'" 
      if(!@city_name.nil? and !@city_name.blank? and !@service_name.nil? and !@service_name.blank?)
        clause_search_bar += " and"
      else
        clause_search_bar +=" or"
      end
      clause_search_bar += " services.name like \'#{@service_name}%\'"
      clause_search_bar
  end
  
  def create_joins
    joins = {}
    joins_with_professional = []
    join_users = {}    
    join_cities = {}
    join_cities['professional_city_coverages'] = 'city'
    joins_with_professional << join_cities
    joins_with_professional << :user   
       
    if(params.key?(:city_name))
      @city_name = params[:city_name]      
    end
    
    if(params.key?(:service_name))
      @service_name = params[:service_name]      
    end            
    
    if(params.key?(:district_id))
      @district_id = params[:district_id]
      join_districts = {}
      join_districts['professional_district_coverages'] = 'district'
      joins_with_professional << join_districts      
    end
          
    if(params.key?(:category_id))
      joins['service'] = 'category'
      @category_id = params[:category_id]    
    end
    joins['professional'] = joins_with_professional
    joins
  end
  
  def create_conditions
    conditions = ['districts', 'categories'].inject({}) do |hash, field|
    if !field.blank?
      if(field == 'districts' and @district_id != nil)
        hash[field] = {id: @district_id}        
      elsif(field == 'categories' and @category_id != nil)
        hash[field] = {id: @category_id}        
      end
      hash 
    end
    end
    conditions
  end
  
  def search_index(joins, clause_search_bar, conditions)
    if (!params[:min_price].blank? and !params[:max_price].blank? ) 
    @professional_services = ProfessionalService.joins(joins, :service).where(conditions)
  .where(clause_search_bar).where("price between "+params[:min_price]+" and "+params[:max_price])
  .active.worker_service.limit(1000).find_each  
    else
      @professional_services = ProfessionalService.joins(joins, :service).where(conditions)
    .where(clause_search_bar).active.worker_service.limit(1000).find_each  
    end  
  end  
  
end
