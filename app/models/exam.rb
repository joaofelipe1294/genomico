class Exam < ActiveRecord::Base
  validates_presence_of :offered_exam, :status
  belongs_to :offered_exam
  belongs_to :attendance
  has_many :exam_status_changes
  before_validation :default_values
  has_and_belongs_to_many :internal_codes
  has_attached_file :report
  validates_attachment_content_type :report, :content_type => ["application/pdf"]
  has_attached_file :partial_released_report
  validates_attachment_content_type :partial_released_report, :content_type => ["application/pdf"]
  after_create :reload_issues_cache
  after_update :reload_issues_cache
  before_update :treat_two_internal_codes_case
  enum status: {
    progress: 1,
    tecnical_released: 2,
    in_repeat: 3,
    complete: 4,
    waiting_start: 5,
    partial_released: 6,
    complete_without_report: 7,
    canceled: 8
  }

  def self.status_name status
    I18n.t "enums.exam.status.#{status}"
  end

  def change_status user_id
    ExamStatusChange.create({
      new_status: self.status,
      exam: self,
      change_date: DateTime.now,
      user_id: user_id
    })
    self.save
  end

  def reopen user_id
    self.report = nil
    self.status = :progress
    attendance = self.attendance
    attendance.reopen if attendance.complete?
    self.change_status user_id
  end

  def is_late?
    days_took = ValidDaysCounterService.new(self.created_at.to_date, Date.current).call
    days_took > self.offered_exam.refference_date
  end

  def verify_if_was_late
    refference_date = self.offered_exam.refference_date
    days_took = ValidDaysCounterService.new(self.created_at.to_date, self.finish_date).call
    if days_took > refference_date
      self.was_late = true
      self.lag_time = days_took - refference_date
    end
  end

  def self.from_field field
    self.joins(:offered_exam).where("offered_exams.field_id = ?", field.id)
  end

  def self.complete
    self.where(status: :complete)
  end

  def self.waiting_start
    self.where(status: :waiting_start)
  end

  def self.progress
    self.where.not(status: [:complete, :canceled])
  end

  def status_name
    I18n.t("enums.exam.status.#{self.status}")
  end

  private

    def default_values
    	self.status = :waiting_start unless self.status
      self.was_late = false unless self.was_late
      self.lag_time = 0 unless  self.lag_time
    end

    def reload_issues_cache
      self.offered_exam.field.set_issues_in_cache
    end

    def treat_two_internal_codes_case
      compose_internal_codes = ComposeInternalCodeGeneratorService.new(self).call
      self.internal_codes = compose_internal_codes if compose_internal_codes
    end

end
