# -*- encoding : utf-8 -*-
class LogEntry < ActiveRecord::Base
  validates_presence_of :log, :admission, :group, :applicant, :member

  belongs_to :applicant
  belongs_to :admission
  belongs_to :group
  belongs_to :member

  default_scope { order(created_at: :asc) }
end

# == Schema Information
# Schema version: 20130422173230
#
# Table name: log_entries
#
#  id           :integer          not null, primary key
#  log          :string(255)
#  admission_id :integer
#  group_id     :integer
#  applicant_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  member_id    :integer
#
