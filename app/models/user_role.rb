class UserRole < ApplicationRecord
  belongs_to :user
  belongs_to :role

  validates :user_id,uniqueness: { scope: :role_id ,
    message: "分配的角色只能唯一" }

end
