class Opinion < ApplicationRecord
  # 打合せ項目への意見機能
  belongs_to :user        # ユーザーが意見登録
  belongs_to :mygroup     # グループ内の意見
  belongs_to :discussion  # 打合せ項目に対しての意見
  
  validates :content, presence: true, length: { maximum: 100 }
  
end
