class Attendance < ActiveRecord::Base
  belongs_to :desease_stage
  belongs_to :patient
  belongs_to :attendance_status_kind
  belongs_to :health_ensurance
end
