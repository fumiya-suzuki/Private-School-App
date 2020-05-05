class User < ApplicationRecord
  has_many :reports, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :tests, dependent: :destroy
  attr_accessor :remember_token
  mount_uploader :image, ImageUploader
  
  validates :name, presence: true
  validates :number, presence: true, length: { minimum: 5 },
                     uniqueness: true
  VALID_TEL_REGEX = /\A\d{10,11}\z/
  validates :tel, presence: true, 
                  format: { with: VALID_TEL_REGEX },
                  uniqueness: true
  validates :grade, presence: true, unless: :user_teacher?
  validates :school, presence: true, unless: :user_teacher?
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
  def User.digest(string)
    cost = 
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # 永続セッションのためハッシュ化したトークンをデータベースに記憶します。
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # トークンがダイジェストと一致すればtrueを返します。
  def authenticated?(remember_token)
    # ダイジェストが存在しない場合はfalseを返して終了します。
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  # ユーザーのログイン情報を破棄します。
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  def user_teacher?
    teacher == true 
  end
  

end
