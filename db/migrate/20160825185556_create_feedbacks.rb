class CreateFeedbacks < ActiveRecord::Migration
  def change

    create_table :feedback_feedbacks do |t|
      t.belongs_to :event, foreign_key: true 
      t.timestamps
    end

    create_table :feedback_answers do |t|
      t.belongs_to :feedback_question, index: true
      
      t.timestamps
    end
    
    create_table :feedback_questions do |t|
      t.belongs_to :feedback_feedbacks, index: true
      t.string :alternative_1
      t.string :alternative_2
      t.string :alternative_3
      t.string :alternative_4
      t.string :text
      
      
      t.timestamps
    end
  end
end
