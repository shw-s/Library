class AddParentIdToCatalogs < ActiveRecord::Migration[5.2]
  def change
    add_column :catalogs, :parent_id, :integer
  end
end
