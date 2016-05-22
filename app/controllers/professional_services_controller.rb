class ProfessionalServicesController < ApplicationController
  
  require_relative '../usefull/query_creator.rb'
  
  before_action :set_professional_service, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  
  # GET /professional_services
  def index
    load_combos_boxes
    
    @professional_services = nil
    load_filters    
    
    q = QueryCreator.new
    joins = q.create_joins_professional_service_index(params)    
    clause_search_bar = get_clause_search_bar    
    conditions = q.create_conditions_professional_service_index(params)
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
  
  @limit_list = 1000
  
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
  
  def search_index(joins, clause_search_bar, conditions)
    clause_price = ""
    if !@max_price.nil? and !@max_price.blank? and !@min_price.nil? and !@min_price.blank?
      clause_price = "price between #{@min_price} and #{@max_price}"       
    end    
     
     
    if !@bol_company.nil?
      if @bol_company
        @professional_services = ProfessionalService.joins(joins, :service).where(conditions)
        .where(clause_search_bar).where(clause_price)
        .active.enterprise_service.limit(@limit_list).find_each
      else
         @professional_services = ProfessionalService.joins(joins, :service).where(conditions)
        .where(clause_search_bar).where(clause_price)
        .active.worker_service.limit(@limit_list).find_each 
      end
    else
      @professional_services = ProfessionalService.joins(joins, :service).where(conditions)
        .where(clause_search_bar).where(clause_price)
        .active.limit(@limit_list).find_each            
    end     
            
  end
  
  def load_filters
    @bol_company = nil   
    @min_price = params[:min_price]
    @max_price = params[:max_price]
    @city_name = ""
    @distric_id = nil
    @category_id = nil
    @service_name = ""    
    if(params.key?(:city_name))
      @city_name = params[:city_name]      
    end
    
    if(params.key?(:service_name))
      @service_name = params[:service_name]      
    end            
    
    if(params.key?(:district_id))
      @district_id = params[:district_id]            
    end
          
    if(params.key?(:category_id))      
      @category_id = params[:category_id]    
    end
    
    if params.key?(:bol_company)
      @bol_company = false
      
      if params[:bol_company] == 'true'       
        @bol_company = true                       
      end
    end
        
        
  end
  
  def load_combos_boxes
    @all_categories = Category.order :name
    @all_locations = District.order :name    
  end    
  
end
