class Article < ApplicationRecord
  require 'roo'
  belongs_to :catalog
  has_one_attached :img
  validates :title,  presence: true,
                      length: { minimum: 1 }
  validates :serial, presence:true
  validates :serial, uniqueness: true
  validates :number, presence: true
					
  has_many :borrows
  has_many :users, through: :borrows
  accepts_nested_attributes_for :users
  
  def self.read_excel(path)

  end

  def self.save_excel(excel_datas)
  end

end