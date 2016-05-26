class ProfessionalService < ActiveRecord::Base

  belongs_to :professional   

  belongs_to :service_unit
  belongs_to :service

  has_one :service_unit

  has_one :user, through: :professional
  has_one :profile, through: :user
  has_many :professional_profession, through: :professional, source: :professional_professions

  has_many :service_professional_feedbacks

  accepts_nested_attributes_for :service_professional_feedbacks
  accepts_nested_attributes_for :service

  validates_presence_of :active,:price,  :created_at, :updated_at

  scope :active, -> {where ("excluded_at IS NULL and professional_services.active = TRUE")}
  
  scope :enterprise_service, -> {where ("char_length(users.cpf) > 11")}
  
  scope :worker_service, -> {where ("char_length(users.cpf) <= 11")}

  public

  def show_image_professional
    @image = ProfessionalProfessionImage.find(params[:id])
    send_data @image.photo_content, :type => 'image/jpg'
  end

end
