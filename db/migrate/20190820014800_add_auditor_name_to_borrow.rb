class AddAuditorNameToBorrow < ActiveRecord::Migration[5.2]
  def change
    add_column :borrows, :auditor_name, :string
  end
end
