class Account < ApplicationRecord
  belongs_to :user
  belongs_to :mygroup
  
  validates :processed_date, presence: true
  validates :treasurer, presence: true
  validates :to_whom, presence: true, length: {maximum: 30 }
  validates :content, presence: true, length: {maximum: 30 }
  validates :fee, presence: true
  
end
