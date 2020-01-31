class Attendance < ActiveRecord::Base
  belongs_to :desease_stage
  belongs_to :patient
  # belongs_to :attendance_status_kind
  belongs_to :health_ensurance
  has_many :exams
  has_many :samples
  has_many :subsamples
  accepts_nested_attributes_for :samples
  accepts_nested_attributes_for :exams
  before_validation :default_values
  validates :desease_stage, :lis_code, :patient, :exams, :samples, :status, presence: true
  validates :lis_code, uniqueness: true
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
    self.attendance_status_kind = AttendanceStatusKind.COMPLETE
    self.save
  end

  def reopen
    self.attendance_status_kind = AttendanceStatusKind.IN_PROGRESS
    self.finish_date = nil
    self.save
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
