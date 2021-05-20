class Omikuji < ApplicationRecord
  validates :result, presence: true, length: {maximum: 10 }
  validates :content, presence: true, length: {maximum: 20 }
end
