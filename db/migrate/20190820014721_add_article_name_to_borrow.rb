class AddArticleNameToBorrow < ActiveRecord::Migration[5.2]
  def change
    add_column :borrows, :article_name, :string
  end
end
