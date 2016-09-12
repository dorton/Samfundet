class AddDetailsToFeedbackAnswer < ActiveRecord::Migration
  def change
    add_column :feedback_answers, :alternative, :decimal
  end
end
