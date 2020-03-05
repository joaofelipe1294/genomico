class FishApiController < ApplicationController

  def users
    users = User.where(is_active: true).order(:login)
    render json: users, status: :ok, only: [:id, :login]
  end

  def exams
    exams = Exam
                .where.not(status: :canceled)
                .where.not(status: :complete)
                .joins(:offered_exam, :internal_codes, attendance: [:patient])
                .where("offered_exams.field_id = ?", Field.FISH.id)
                .order(created_at: :desc)
    response = exams.map do |exam|
      {
        id: exam.id,
        patient: exam.attendance.patient.name,
        exam: exam.offered_exam.name,
        sample_id: exam.internal_codes.first.subsample.id,
        subsample_label: exam.internal_codes.first.subsample.refference_label,
        status: exam.status_name,
        started_at: (I18n.l(exam.start_date) if exam.start_date)
      }
    end
    render json: response, status: :ok
  end

end
