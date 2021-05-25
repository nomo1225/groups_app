class Attendance < ApplicationRecord
  # Users attend(ユーザーが予定に参加(中間テーブル))
  belongs_to :user
  belongs_to :plan
end
