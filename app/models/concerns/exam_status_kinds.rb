module ExamStatusKinds
  extend ActiveSupport::Concern
  WAITING_START = ExamStatusKind.WAITING_START
  COMPLETE_WITHOUT_REPORT = ExamStatusKind.COMPLETE_WITHOUT_REPORT
  COMPLETE = ExamStatusKind.COMPLETE
  IN_REPEAT = ExamStatusKind.IN_REPEAT
  TECNICAL_RELEASED = ExamStatusKind.TECNICAL_RELEASED
  CANCELED = ExamStatusKind.CANCELED
end
