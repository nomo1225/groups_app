class Notice < ApplicationRecord
  # お知らせ機能
  belongs_to :user    # ユーザーがお知らせを登録
  belongs_to :mygroup # グループのお知らせ
  
  validates :title, presence: true, length: {maximum: 30 }
  validates :content, presence: true, length: {maximum: 100 }
end
