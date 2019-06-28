class PanelsController < ApplicationController
  
  def exams
  	@waiting_exams = Exam.where(exam_status_kind: ExamStatusKind.find_by(name: 'Aguardando início'))
  	@in_progress_exams = Exam.where(exam_status_kind: ExamStatusKind.find_by(name: 'Em andamento'))
  	@technical_released_exams = Exam.where(exam_status_kind: ExamStatusKind.find_by(name: 'Liberado técnico'))
  	@in_repeat_exams = Exam.where(exam_status_kind: ExamStatusKind.find_by(name: 'Em repetição'))
  end

  def attendances
  end
  
end
