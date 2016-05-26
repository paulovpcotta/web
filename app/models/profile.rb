class Profile < ActiveRecord::Base
  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "120x90#" }, default_url: "/images/no-avatar.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  
end
