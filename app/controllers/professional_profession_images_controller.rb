class ProfessionalProfessionImagesController < ApplicationController
  before_action :set_professional_profession_image, only: [:show, :edit, :update, :destroy]

  # GET /professional_profession_images
  def index
    @professional_profession_images = ProfessionalProfessionImage.all
  end

  # GET /professional_profession_images/1
  def show
  end

  # GET /professional_profession_images/new
  def new
    @professional_profession_image = ProfessionalProfessionImage.new
  end

  # GET /professional_profession_images/1/edit
  def edit
  end

  # POST /professional_profession_images
  def create
    @professional_profession_image = ProfessionalProfessionImage.new(professional_profession_image_params)

    if @professional_profession_image.save
      redirect_to @professional_profession_image, notice: t('helpers.messages.save' , model:t('activerecord.models.professional_profession_image.one'))
    else
      render :new
    end
  end

  # PATCH/PUT /professional_profession_images/1
  def update
    if @professional_profession_image.update(professional_profession_image_params)
      redirect_to @professional_profession_image, notice: t('helpers.messages.update' , model:t('activerecord.models.professional_profession_image.one'))
    else
      render :edit
    end
  end

  # DELETE /professional_profession_images/1
  def destroy
    @professional_profession_image.destroy
    redirect_to professional_profession_images_url, notice: t('helpers.messages.delete' , model:t('activerecord.models.professional_profession_image.one'))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_professional_profession_image
      @professional_profession_image = ProfessionalProfessionImage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def professional_profession_image_params
      params.require(:professional_profession_image).permit(:photo)
    end
end
