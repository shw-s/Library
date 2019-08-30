class AddAncestryToCatalogs < ActiveRecord::Migration[5.2]
  def change
    add_column :catalogs, :ancestry, :string
    add_index :catalogs, :ancestry
  end
end
