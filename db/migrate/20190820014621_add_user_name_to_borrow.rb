class AddUserNameToBorrow < ActiveRecord::Migration[5.2]
  def change
    add_column :borrows, :user_name, :string
  end
end
