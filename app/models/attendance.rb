class Attendance < ActiveRecord::Base
  belongs_to :desease_stage
  belongs_to :patient
  belongs_to :attendance_status_kind
  belongs_to :health_ensurance
  has_many :exams
  has_many :samples
  accepts_nested_attributes_for :samples
  accepts_nested_attributes_for :exams
end
