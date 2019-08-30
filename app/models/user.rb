class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_roles
  has_many :roles, through: :user_roles 
  accepts_nested_attributes_for :roles

  has_many :borrows
  has_many :articles, through: :borrows
  # Email is not required
  def email_required?
    false
  end 
  
  def admin?
    self.role == "admin"
  end
end
