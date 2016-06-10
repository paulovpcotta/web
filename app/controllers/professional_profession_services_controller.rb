class ProfessionalProfessionServicesController < ApplicationController
  
  require_relative '../usefull/query_creator.rb'
  
  before_action :set_professional_profession_service, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  respond_to :html, :js

  # GET /professional_profession_services
  def index
    load_combos_boxes
    
    @professional_profession_services = nil
    load_filters    
    
    q = QueryCreator.new
    joins = q.create_joins_professional_profession_service_index(params)    
    clause_search_bar = get_clause_search_bar    
    conditions = q.create_conditions_professional_profession_service_index(params)
    search_index(joins, clause_search_bar, conditions)
    
    respond_to do |format|
      format.html
      format.js
    end
    
  end

  # GET /professional_profession_services/1
  def show
  end

  # GET /professional_profession_services/new
  def new
    @professional_profession_service = ProfessionalProfessionService.new
  end

  # GET /professional_profession_services/1/edit
  def edit
  end

  # POST /professional_profession_services
  def create
    @professional_profession_service = ProfessionalProfessionService.new(professional_profession_service_params)

    if @professional_profession_service.save
      redirect_to @professional_profession_service, notice: t('helpers.messages.save' , model:t('activerecord.models.professional_profession_service.one'))
    else
      render :new
    end
  end

  # PATCH/PUT /professional_profession_services/1
  def update
    if @professional_profession_service.update(professional_profession_service_params)
      redirect_to @professional_profession_service, notice: t('helpers.messages.update' , model:t('activerecord.models.professional_profession_service.one'))
    else
      render :edit
    end
  end

  # DELETE /professional_profession_services/1
  def destroy
    @professional_profession_service.destroy
    redirect_to professional_profession_services_url, notice: t('helpers.messages.delete' , model:t('activerecord.models.professional_profession_service.one'))
  end

  private
  
  @limit_list = 1000
  
    # Use callbacks to share common setup or constraints between actions.
    def set_professional_profession_service
      @professional_profession_service = ProfessionalProfessionService.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def professional_profession_service_params
      params.require(:professional_profession_service).permit(:professional_profession_id, :service_id, :service_unit_id, :price, :active, :excluded_at)
    end
    
    def get_clause_search_bar
      clause_search_bar = ""
      
      if(!@city_name.nil? and !@city_name.blank? )
        clause_search_bar = "lower(cities.name) like lower\'#{@city_name}%\')"  
      end
       
      if !clause_search_bar.blank?
        if(!@city_name.nil? and !@city_name.blank? and !@service_name.nil? and !@service_name.blank?)
          clause_search_bar += " and"
        else
          clause_search_bar +=" or"
        end  
      end
      
      if(!@service_name.nil? and !@service_name.blank? )
        clause_search_bar += " lower(services.name) like lower(\'#{@service_name}%\')"  
      end       
      
      clause_search_bar
    end
    
    def search_index(joins, clause_search_bar, conditions)
      clause_price = ""
      if !@max_price.nil? and !@max_price.blank? and !@min_price.nil? and !@min_price.blank?
        clause_price = "price between #{@min_price} and #{@max_price}"       
      end    
       
       
      if !@bol_company.nil?
        if @bol_company
          @professional_profession_services = ProfessionalProfessionService.joins(joins, :service).where(conditions)
          .where(clause_search_bar).where(clause_price)
          .active.enterprise_service.limit(@limit_list)
        else
           @professional_profession_services = ProfessionalProfessionService.joins(joins, :service).where(conditions)
          .where(clause_search_bar).where(clause_price)
          .active.worker_service.limit(@limit_list)
        end
      else
        @professional_profession_services = ProfessionalProfessionService.joins(joins, :service).where(conditions)
          .where(clause_search_bar).where(clause_price)
          .active.limit(@limit_list) 
      end 
      
      if(params.key?('by_lower_price') and !params['by_lower_price'].nil?)
        order_by_price
      end
      
      @professional_profession_services = Kaminari.paginate_array(@professional_profession_services).page(params[:page]).per(2)
      
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
    
    def order_by_price()
      @by_lower_price = params['by_lower_price']
      if(params['by_lower_price'] == 'true')
        @professional_profession_services = @professional_profession_services.sort { |a, b| a.price <=> b.price }
      else
        @professional_profession_services = @professional_profession_services.sort { |a, b| b.price <=> a.price }
      end
    end
     
end
