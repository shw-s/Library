class Catalog < ApplicationRecord
  has_many :articles, dependent: :destroy
  validates :name, uniqueness: true

  
  # has_many :children,class_name: "Catalog",
  #                       foreign_key: "parent_id"
  
  # belongs_to :parent ,class_name:"Catalog",
  #                     foreign_key:"parent_id", optional: true
  
  before_save  :save_parent_name
  
  has_ancestry

  def save_parent_name
    self.parent_name = self.parent.name if self.parent_name.blank?  && self&.parent
  end
  
end
