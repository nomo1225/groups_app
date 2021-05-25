class Plan < ApplicationRecord
  # 予定機能
  belongs_to :mygroup                         # グループ内の予定
  has_many :attendances, dependent: :destroy  # 多くの参加者
  has_many :attenders, through: :attendances, source: :user, dependent: :destroy # 参加者全員
  
  validates :title, presence: true, length: {maximum: 20 }
  validates :content, presence: true, length: {maximum: 20 }
  validates :start_time, presence: true
  validates :plan_at, presence: true
  validate :date_before_start
  geocoded_by :address                              # Gem Geocoderで住所から緯度経度へ変換
  after_validation :geocode, if: :address_changed?  # 住所に変更があれば、緯度経度も変換
  
  def date_before_start # 過去の予定は登録不可
    return if start_time.blank?
    errors.add(:start_time, "は過去の日付で登録できません。") if start_time < Date.today
  end

end
