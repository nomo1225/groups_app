class Relationship < ApplicationRecord
  # ユーザーとグループの紐づけ(ユーザーがグループに参加)
  belongs_to :user
  belongs_to :mygroup
end
