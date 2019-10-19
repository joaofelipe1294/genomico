class Attendance < ActiveRecord::Base
  belongs_to :desease_stage
  belongs_to :patient
  belongs_to :attendance_status_kind
  belongs_to :health_ensurance
  has_many :exams
  has_many :samples
  has_many :subsamples
  accepts_nested_attributes_for :samples
  accepts_nested_attributes_for :exams
  before_validation :default_values
  validates :desease_stage, :lis_code, :patient, :exams, :samples, :attendance_status_kind, presence: true
  validates :lis_code, uniqueness: true
  has_attached_file :report
  validates_attachment_content_type :report, :content_type => ["application/pdf"]
  has_and_belongs_to_many :work_maps
  paginates_per 10
  has_many :internal_codes
  after_create :update_cache
  # before_create :convert_data
  # before_create :metodu

  def conclude
    self.finish_date = Date.today
    self.attendance_status_kind = AttendanceStatusKind.COMPLETE
    self.save
  end

  private

  def default_values
    self.start_date = Date.today if self.start_date.nil?
    self.attendance_status_kind = AttendanceStatusKind.IN_PROGRESS if self.attendance_status_kind.nil?
    # treat_exams_as_json
    # treat_samples_as_json
  end

  # def convert_data
  #   puts "=============================== CONVERT DATA ==============================="
  #   treat_exams_as_json
  #   treat_samples_as_json
  # end

  def update_cache
    Field.IMUNOFENO.set_issues_in_cache
    Field.BIOMOL.set_issues_in_cache
    Field.FISH.set_issues_in_cache
  end

  # def metodu
  #   puts "========================= METODO ========================="
  #   treat_exams_as_json
  #   treat_samples_as_json
  # end

  # def treat_exams_as_json
  #   puts "=============== TRATANDIS =============="
  #   if self.exams.is_a? String
  #     exams_json = JSON.parse self.exams
  #     self.exams = exams_json.map { |exam_json| Exam.new(exam_json)}
  #   end
  # end
  #
  # def treat_samples_as_json
  #   if self.samples.is_a? String
  #     samples_json = JSON.parse self.samples
  #     self.samples = samples_json.map { |sample_json| Sample.new(sample_json)}
  #   end
  # end

  # def prepare_exams_and_samples
  #   # puts "=========== PREPARE DATA ================"
  #   # p params
  #   permitted_params = params.require(:attendance).permit(:exams, :samples)
  #   exams_json = JSON.parse permitted_params[:exams]
  #   samples_json = JSON.parse permitted_params[:samples]
  #   # p exams_json
  #   exams = exams_json.map { |exam_json| Exam.new(exam_json)}
  #   samples = samples_json.map { |sample_json| Sample.new(sample_json) }
  #   # p exams
  #   # p samples
  #   # puts "========================================="
  #   # params.delete("exams")
  #   # params.delete(:samples)
  #   params[:exams] = exams
  #   params[:samples] = samples
  # end


end
