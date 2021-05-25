class User < ApplicationRecord
  # ユーザー機能
  before_save { self.email.downcase! }
  VALID_PASSWORD_REGEX =/\A(?=.*?[a-z])(?=.*?[\d])\w{6,12}\z/
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }     #email用のバリデ
  validates :password, presence: true,
                       format: { with: VALID_PASSWORD_REGEX,
                       message: "は半角英数字6~12文字、各１文字以上含む必要があります"}
                       
  has_secure_password                   #パスワード暗号化・再入力(confirmation)確認・認証
  mount_uploader :image, ImageUploader  # Gem carriewaveでの画像アップロード
  
  has_many :mygroups, dependent: :destroy # ユーザーはグループを作成
  has_many :relationships, dependent: :destroy # ユーザー・グループの紐づけ
  has_many :joined_mygroups, through: :relationships, source: :mygroup, dependent: :destroy # 参加済みグループ
  has_many :notices, dependent: :destroy # お知らせ登録
  has_many :plans, dependent: :destroy # 予定登録
  has_many :attendances, dependent: :destroy # 予定に参加
  has_many :attends, through: :attendances, source: :plan, dependent: :destroy # 参加予定の予定
  has_many :discussions, dependent: :destroy # 打合せ登録
  has_many :opinions, dependent: :destroy # 意見を登録(打ち合わせに)
  has_many :accounts, dependent: :destroy # 会計情報登録

  def join(mygroup) #グループに参加
    self.relationships.find_or_create_by(mygroup_id: mygroup.id)
  end
  def secession(mygroup) #グループから退会
    relationship = self.relationships.find_by(mygroup_id: mygroup.id)
    relationship.destroy if relationship
  end
  def joining?(mygroup) #グループに参加済みか
    self.joined_mygroups.include?(mygroup)
  end
  
  def attend(plan) #予定に参加
    self.attendances.find_or_create_by(plan_id: plan.id)
  end
  def unattend(plan) #予定に不参加
    attendance = self.attendances.find_by(plan_id: plan.id)
    attendance.destroy if attendance
  end
  def attending?(plan) #予定に参加済みか
    self.attends.include?(plan)
  end

end
