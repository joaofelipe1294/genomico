class Attendance < ActiveRecord::Base
  belongs_to :patient
  belongs_to :health_ensurance
  has_many :exams
  has_many :samples
  has_many :subsamples
  accepts_nested_attributes_for :samples
  accepts_nested_attributes_for :exams
  before_validation :default_values
  validates_presence_of :lis_code, :patient, :exams, :samples, :status, :desease_stage
  validates_uniqueness_of :lis_code
  has_attached_file :report
  validates_attachment_content_type :report, :content_type => ["application/pdf"]
  has_and_belongs_to_many :work_maps
  paginates_per 10
  has_many :internal_codes
  after_create :update_cache
  enum desease_stage:  {
    diagnosis: 1,
    relapse: 2,
    drm: 3,
    subpop: 4,
    subpop_ret: 5,
    immune_profile: 6
  }

  enum status: {
    progress: 1,
    complete: 2
  }

  def status_name
    I18n.t("enums.attendance.statuses.#{self.status}")
  end


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
    self.exams.progress.empty?
  end

  def has_pendent_reports?
    exams = self.exams
    pendent_report_exams_count = exams.where(status: :complete_without_report).size
    in_progress_exams = exams.progress.size
    return pendent_report_exams_count == in_progress_exams if in_progress_exams > 0
    false
  end

  def self.desease_stages_for_select
    desease_stages.map do |desease_stage, _|
      [ I18n.t("enums.attendance.desease_stages.#{desease_stage}"), desease_stage ]
    end
  end

  def desease_stage_name
    I18n.t("enums.attendance.desease_stages.#{self.status}")
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
