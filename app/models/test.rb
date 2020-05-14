class Test < ApplicationRecord
  belongs_to :user
  
  validates :english,  :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 200 }
  validates :math,  :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 200 }
  validates :japanese,  :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 200 }
  validates :science,  :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 200 }
  validates :society,  :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 200 }
  validates :name, presence: true
  validates :day, presence: true
  validates :types, presence: true
  
  before_save do
    self.five_subjects = english + math + japanese + science + society
    self.three_subjects = english + math + japanese
  end
end
