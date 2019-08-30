class AddParentNameToCatalogs < ActiveRecord::Migration[5.2]
  def change
    add_column :catalogs, :parent_name, :string
  end
end
