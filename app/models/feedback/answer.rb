class Feedback::Answer < ActiveRecord::Base
   attr_accessible :question, :alternative

   belongs_to :question
end
