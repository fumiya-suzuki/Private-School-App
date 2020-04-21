class Report < ApplicationRecord
  belongs_to :user
  
  validates :subject, presence: true
  validates :note, presence: true
  validates :day, presence: true
end
