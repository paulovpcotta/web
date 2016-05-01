class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :cpf,:first_name,:last_name,:gender

  belongs_to :phone

  accepts_nested_attributes_for :phone, allow_destroy: true

  attr_accessor :term

end
