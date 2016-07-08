class ProfessionalProfessionImage < ActiveRecord::Base
  has_attached_file :photo, :styles => { :medium => "816x460>", :thumb => "120x90#" }, default_url: "/images/no-avatar.jpg"
  belongs_to :professional_profession

  has_one :professional, through: :professional_profession
  has_one :profession, through: :professional_profession


  validates_attachment :photo, presence: true,
                       content_type: { content_type: "image/jpeg" },
                       size: { in: 0..10.megabytes }
end
