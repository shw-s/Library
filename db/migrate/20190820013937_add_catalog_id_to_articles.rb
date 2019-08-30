class AddCatalogIdToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :catalog_id, :integer
  end
end
