class Notice < ApplicationRecord
  belongs_to :user
  belongs_to :mygroup
  
  validates :title, presence: true, length: {maximum: 25 }
  validates :content, presence: true, length: {maximum: 100 }
end
