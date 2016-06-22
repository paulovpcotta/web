class FeedbackTypesController < ApplicationController
  before_action :set_feedback_type, only: [:show, :edit, :update, :destroy]

  # GET /feedback_types
  def index
    @feedback_types = FeedbackType.all
  end

  # GET /feedback_types/1
  def show
  end

  # GET /feedback_types/new
  def new
    @feedback_type = FeedbackType.new
  end

  # GET /feedback_types/1/edit
  def edit
  end

  # POST /feedback_types
  def create
    @feedback_type = FeedbackType.new(feedback_type_params)

    if @feedback_type.save
      redirect_to @feedback_type, notice: t('helpers.messages.save' , model:t('activerecord.models.feedback_type.one'))
    else
      render :new
    end
  end

  # PATCH/PUT /feedback_types/1
  def update
    if @feedback_type.update(feedback_type_params)
      redirect_to @feedback_type, notice: t('helpers.messages.update' , model:t('activerecord.models.feedback_type.one'))
    else
      render :edit
    end
  end

  # DELETE /feedback_types/1
  def destroy
    @feedback_type.destroy
    redirect_to feedback_types_url, notice: t('helpers.messages.delete' , model:t('activerecord.models.feedback_type.one'))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback_type
      @feedback_type = FeedbackType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def feedback_type_params
      params.require(:feedback_type).permit(:name, :description, :active)
    end
end
