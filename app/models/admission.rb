# -*- encoding : utf-8 -*-
class Admission < ActiveRecord::Base
  has_many :jobs
  has_many :job_applications, -> { uniq }, through: :jobs
  has_many :groups, -> { uniq }, through: :jobs
  has_many :group_types,-> { uniq }, through: :groups

  validates_presence_of :title, :shown_from, :shown_application_deadline,
                        :actual_application_deadline, :user_priority_deadline,
                        :admin_priority_deadline
  validates_format_of :shown_from,
                      :shown_application_deadline,
                      :actual_application_deadline,
                      :user_priority_deadline,
                      :admin_priority_deadline,
                      with: /\A[0-3][0-9].[01][0-9].[0-9]{4,4}  # The date.
                               \                                  # A space.
                               [0-2][0-9]:[0-5][0-9]\Z/x # The time.

  # An admission has five datetimes associated with it:
  #
  #   shown_from                  - The admission is shown on the front page
  #                                 from that datetime.
  #   shown_application_deadline  - The datetime specifying the application
  #                                 deadline to the user.
  #   actual_application_deadline - The actual deadline for applying. From our
  #                                 experience, some users are slow.
  #   user_priority_deadline      - The deadline for users to prioritize their
  #                                 applications.
  #   admin_priority_deadline     - The deadline for admissions admins to
  #                                 prioritize their applicants.

  validates_each :shown_application_deadline do |record, attr, value|
    objects_exist = !value.nil? && !record.shown_from.nil?
    if objects_exist && value < record.shown_from
      record.errors.add(
        attr,
        I18n.t("helpers.models.admission.errors.deadline_before_visible")
      )
    end
  end

  validates_each :actual_application_deadline do |record, attr, value|
    objects_exist = !value.nil? && !record.shown_application_deadline.nil?
    if objects_exist && value < record.shown_application_deadline
      record.errors.add(
        attr,
        I18n.t("helpers.models.admission.errors.deadline_before_shown_deadline")
      )
    end
  end

  validates_each :user_priority_deadline do |record, attr, value|
    objects_exist = !value.nil? && !record.actual_application_deadline.nil?
    if objects_exist && value < record.actual_application_deadline
      record.errors.add(
        attr,
        I18n.t("helpers.models.admission.errors.priority_before_application")
      )
    end
  end

  validates_each :admin_priority_deadline do |record, attr, value|
    objects_exist = !value.nil? && !record.user_priority_deadline.nil?
    if objects_exist && value < record.user_priority_deadline
      record.errors.add(
        attr,
        I18n.t("helpers.models.admission.errors.admin_deadline_before_user")
      )
    end
  end

  default_scope { order(shown_application_deadline: :desc)  }

  # We must use lambdas so that the time is not 'cached' on server start.
  scope :current, (lambda do
    where("user_priority_deadline > ?", 2.weeks.ago)
    .order("user_priority_deadline DESC")
  end)

  scope :appliable, (lambda do
    where("shown_from < ? and actual_application_deadline > ?",
          Time.current, Time.current)
  end)

  scope :active, (lambda do
    where("shown_from < ? and admin_priority_deadline > ?",
          Time.current, Time.current)
  end)

  scope :no_longer_appliable, (lambda do
    where("actual_application_deadline < ?", Time.current)
  end)

  scope :upcoming, (lambda do
    where("shown_from > ?", Time.current)
  end)

  # Remember that scopes are composable, meaning that one could
  # call "Admission.appliable.with_relations".
  scope :with_relations, -> { includes(jobs: { group: :group_type } ) }

  def self.has_open_admissions?
    !Admission.appliable.empty?
  end

  # Defined as at admin priority deadline not passed
  def self.has_active_admissions?
    Admission.active.any?
  end

  def appliable?
    (actual_application_deadline > Time.current) && (shown_from < Time.current)
  end

  def has_jobs?
    !jobs.empty?
  end

  def interview_dates
    from = actual_application_deadline.to_date + 1.day
    to   = user_priority_deadline.to_date

    (from..to).to_a
  end

  def to_s
    "#{title} (#{I18n.localize shown_application_deadline, format: :short})"
  end

  def to_param
    if title.nil?
      super
    else
      "#{id}-#{title.parameterize}"
    end
  end
end

# == Schema Information
# Schema version: 20130422173230
#
# Table name: admissions
#
#  id                          :integer          not null, primary key
#  title                       :string(255)
#  shown_application_deadline  :datetime
#  user_priority_deadline      :datetime
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  shown_from                  :datetime
#  admin_priority_deadline     :datetime
#  actual_application_deadline :datetime
#
