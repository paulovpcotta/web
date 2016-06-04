class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :phone
  has_one :profile

  has_many :service_professional_feedbacks
  has_many :professionals
  has_many :professional_professions, through: :professionals

  validates_presence_of :cpf,:first_name,:last_name,:gender  

  accepts_nested_attributes_for :phone, allow_destroy: true

  attr_accessor :term

end
