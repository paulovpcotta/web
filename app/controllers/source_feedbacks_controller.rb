class SourceFeedbacksController < ApplicationController
  before_action :set_source_feedback, only: [:show, :edit, :update, :destroy]

  # GET /source_feedbacks
  def index
    @source_feedbacks = SourceFeedback.all
  end

  # GET /source_feedbacks/1
  def show
  end

  # GET /source_feedbacks/new
  def new
    @source_feedback = SourceFeedback.new
  end

  # GET /source_feedbacks/1/edit
  def edit
  end

  # POST /source_feedbacks
  def create
    @source_feedback = SourceFeedback.new(source_feedback_params)

    if @source_feedback.save
      redirect_to @source_feedback, notice: t('helpers.messages.save' , model:t('activerecord.models.source_feedback.one'))
    else
      render :new
    end
  end

  # PATCH/PUT /source_feedbacks/1
  def update
    if @source_feedback.update(source_feedback_params)
      redirect_to @source_feedback, notice: t('helpers.messages.update' , model:t('activerecord.models.source_feedback.one'))
    else
      render :edit
    end
  end

  # DELETE /source_feedbacks/1
  def destroy
    @source_feedback.destroy
    redirect_to source_feedbacks_url, notice: t('helpers.messages.delete' , model:t('activerecord.models.source_feedback.one'))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_source_feedback
      @source_feedback = SourceFeedback.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def source_feedback_params
      params.require(:source_feedback).permit(:professional_id, :professional_profession_id, :professional_profession_service_id, :feedback_type_id)
    end
end
