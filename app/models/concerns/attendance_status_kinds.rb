module AttendanceStatusKinds
  extend ActiveSupport::Concern
  IN_PROGRESS = AttendanceStatusKind.IN_PROGRESS
  COMPLETE = AttendanceStatusKind.COMPLETE
end
