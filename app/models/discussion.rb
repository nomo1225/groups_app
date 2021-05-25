class Discussion < ApplicationRecord
  # 打合せ機能
  belongs_to :user                        # ユーザーが項目を作成
  belongs_to :mygroup                     # グループに対して作成
  has_many :opinions, dependent: :destroy # 多くの意見がある
  
  validates :title, presence: true, length: {maximum: 30 }
  validates :content, presence: true, length: {maximum: 150 }
end
