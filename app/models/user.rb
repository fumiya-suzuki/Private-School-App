class User < ApplicationRecord
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
end
