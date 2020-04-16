class User < ApplicationRecord
  attr_accessor :remember_token
  
  validates :name, presence: true
  validates :number, presence: true, length: { minimum: 5 },
                     uniqueness: true
  VALID_TEL_REGEX = /\A\d{10,11}\z/
  validates :tel, presence: true, 
                  format: { with: VALID_TEL_REGEX },
                  uniqueness: true
  validates :grade, presence: true
  validates :school, presence: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  
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
end
