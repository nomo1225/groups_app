class Account < ApplicationRecord
  # Account 会計情報
  belongs_to :user    #ユーザーは何度か支払をする
  belongs_to :mygroup #グループには多くの支払がある
  
  validates :processed_date, presence: true
  validates :treasurer, presence: true
  validates :to_whom, presence: true, length: {maximum: 30 }
  validates :content, presence: true, length: {maximum: 30 }
  validates :fee, presence: true
  
end
