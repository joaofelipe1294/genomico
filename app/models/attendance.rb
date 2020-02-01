class Attendance < ActiveRecord::Base
  belongs_to :desease_stage
  belongs_to :patient
  belongs_to :health_ensurance
  has_many :exams
  has_many :samples
  has_many :subsamples
  accepts_nested_attributes_for :samples
  accepts_nested_attributes_for :exams
  before_validation :default_values
  validates_presence_of :desease_stage, :lis_code, :patient, :exams, :samples, :status
  validates_uniqueness_of :lis_code
  has_attached_file :report
  validates_attachment_content_type :report, :content_type => ["application/pdf"]
  has_and_belongs_to_many :work_maps
  paginates_per 10
  has_many :internal_codes
  after_create :update_cache
  enum status: {
    progress: 1,
    complete: 2
  }

  def conclude
    self.finish_date = Date.today
    self.status = :complete
    self.save
  end

  def reopen
    self.status = :progress
    self.finish_date = nil
    self.save
  end

  def all_exams_are_complete?
    self.exams.where.not(exam_status_kind: [ExamStatusKind.COMPLETE, ExamStatusKind.CANCELED]).empty?
  end

  def has_pendent_reports?
    self.exams.where(exam_status_kind: ExamStatusKind.COMPLETE_WITHOUT_REPORT).empty?
  end

  def status_name
    I18n.t("enums.attendance.statuses.#{self.status}")
  end

  private

    def default_values
      self.start_date = Date.today if self.start_date.nil?
      self.status = :progress if self.status.nil?
    end

    def update_cache
      Field.IMUNOFENO.set_issues_in_cache
      Field.BIOMOL.set_issues_in_cache
      Field.FISH.set_issues_in_cache
    end  # TODO: extrair para service isolado ou modulo que gerencie o cache, talves se aplique a field !!!

end
