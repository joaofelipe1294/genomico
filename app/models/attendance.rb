class Attendance < ActiveRecord::Base
  belongs_to :desease_stage
  belongs_to :patient
  belongs_to :attendance_status_kind
  belongs_to :health_ensurance
  has_many :exams
  has_many :samples
  accepts_nested_attributes_for :samples
  accepts_nested_attributes_for :exams
  after_initialize :default_values
  validates :lis_code, :patient, :exams, :samples, presence: true

  def default_values
    self.start_date = Date.today if self.start_date.nil?
    self.attendance_status_kind = AttendanceStatusKind.find_by({name: 'Em andamento'}) if self.attendance_status_kind.nil?
  end
end
