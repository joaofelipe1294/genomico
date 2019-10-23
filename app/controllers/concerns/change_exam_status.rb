module ChangeExamStatus
  extend ActiveSupport::Concern
  include ExamStatusKinds

  def completed
		@exam.exam_status_kind = ExamStatusKinds::COMPLETE_WITHOUT_REPORT
		@exam.finish_date = DateTime.now
		apply_changes
	end

  def change_to_partial_released
    @exam.exam_status_kind = ExamStatusKinds::PARTIAL_RELEASED
    @exam.partial_released_report = exam_params[:partial_released_report]
    apply_changes
  end

  def initiate
    @exam.internal_code_ids = params[:internal_code_ids]
    @exam.start_date = Date.today
    @exam.exam_status_kind = ExamStatusKinds::IN_PROGRESS
    apply_changes
  end

  def change_exam_status
    @exam.exam_status_kind_id = params[:new_status]
    apply_changes
  end

  def apply_changes
    exam_status_kind = @exam.exam_status_kind
    if @exam.change_status session[:user_id]
      flash[:success] = "Status de exame alterado para #{exam_status_kind.name}."
      return redirect_to add_report_to_exam_path(@exam) if exam_status_kind == ExamStatusKinds::COMPLETE_WITHOUT_REPORT
    else
      flash[:error] = @exam.erros.first.complete_message
    end
    redirect_to_exams_tab
  end

end
