class Feedback::Question < ActiveRecord::Base
  attr_accessible :text, :feedback, :alternative_1,
                  :alternative_2, :alternative_3, :alternative_4,
                  :answers
  
  has_many :answers
  belongs_to :feedback
end
