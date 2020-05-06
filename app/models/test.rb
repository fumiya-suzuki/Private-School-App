class Test < ApplicationRecord
  belongs_to :user
  
  before_save do
    self.five_subjects = english + math + japanese + science + society
    self.three_subjects = english + math + japanese
  end
end
