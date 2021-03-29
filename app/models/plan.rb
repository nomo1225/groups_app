class Plan < ApplicationRecord
  belongs_to :mygroup
  
  has_many :attendances, dependent: :destroy
  has_many :attenders, through: :attendances, source: :user, dependent: :destroy
  
  validates :title, presence: true, length: {maximum: 20 }
  validates :content, presence: true, length: {maximum: 20 }
  validates :start_time, presence: true
  validates :plan_at, presence: true
  validate :date_before_start
  
  
  def date_before_start
    return if start_time.blank?
    errors.add(:start_time, "は過去の日付で登録できません。") if start_time < Date.today
  end

end
