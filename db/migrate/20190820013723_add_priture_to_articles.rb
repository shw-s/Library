class AddPritureToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :priture, :text
  end
end
