class ExamStatusChange < ActiveRecord::Base
  belongs_to :exam
  belongs_to :exam_status_kind
end
