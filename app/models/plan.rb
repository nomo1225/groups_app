class Plan < ApplicationRecord
  belongs_to :mygroup
  
  has_many :attendances, dependent: :destroy
  has_many :attenders, through: :attendances, source: :user, dependent: :destroy
  
  validates :title, presence: true, length: {maximum: 20 }
  validates :content, presence: true, length: {maximum: 20 }
  validates :start_time, presence: true
  validates :plan_at, presence: true

end
