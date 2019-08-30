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
  
  def self.read_excel(file)
    xlsx = Roo::Spreadsheet.open(file)
      message = ""
      xlsx.sheet("Sheet1").each_with_index do |row,index|
        next if index == 0
        title = row[0]
        text =  row[1]
        serial = row[2]
        number = row[3]
        catalog =row[4] 
        unless catalog = Catalog.find_by(name: catalog)
          catalog = Catalog.create(name: row[4])
          catalog.save
        end     
        article = Article.new(title:title, text:text, serial:serial, number:number, catalog_id:catalog.id) 
        article.save
        message << "第"+"#{index+1}"+"行"+"保存失败，失败原因是:"+article.errors.full_messages.join(',') if !article.save
      end
    message
  end
end