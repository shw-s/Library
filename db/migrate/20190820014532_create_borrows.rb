class CreateBorrows < ActiveRecord::Migration[5.2]
  def change
    create_table :borrows do |t|
      t.integer :article_id
      t.integer :state
      t.string :reason
      t.integer :auditor_id
      t.integer :user_id
    end
  end
end
