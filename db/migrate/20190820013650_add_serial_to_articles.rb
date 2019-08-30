class AddSerialToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :serial, :integer
  end
end
