class ProfessionalService < ActiveRecord::Base

  belongs_to :professional

  belongs_to :service_unit
  belongs_to :service

  #has_one :user, through: :professional, source: :professional_professions
  #has_many :professional_profession, through: :professional, source: :professional_professions

  has_many :service_professional_feedbacks

  accepts_nested_attributes_for :service_professional_feedbacks
  accepts_nested_attributes_for :service

  validates_presence_of :active,:price,  :created_at, :updated_at

  scope :active, -> {where ("excluded_at IS NULL and active = TRUE")}

  public

  def show_image_professional
    @image = ProfessionalProfessionImage.find(params[:id])
    send_data @image.photo_content, :type => 'image/jpg'
  end

end
