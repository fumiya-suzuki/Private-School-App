class Attendance < ApplicationRecord
  belongs_to :user
  
  validates :worked_on, presence: true
  validates :c_one,  :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10 }, allow_blank: true
  validates :c_two,  :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10 }, allow_blank: true
  validates :k_one,  :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10 }, allow_blank: true
  validates :k_two,  :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10 }, allow_blank: true
end
