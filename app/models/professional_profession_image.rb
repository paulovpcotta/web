class ProfessionalProfessionImage < ActiveRecord::Base
  belongs_to :professional_profession

  has_one :professional, through: :professional_profession
  has_one :profession, through: :professional_profession

  has_attached_file :photo_content, styles: { medium: "300x300>", thumb: "100x100>" }

  validates_attachment :photo_content, presence: true,
                       content_type: { content_type: "image/jpeg" },
                       size: { in: 0..10.megabytes }
end
