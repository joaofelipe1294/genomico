module ChangeExamStatus
  extend ActiveSupport::Concern
  include ExamStatusKinds

  def completed
		@exam.exam_status_kind = ExamStatusKinds::COMPLETE_WITHOUT_REPORT
		@exam.finish_date = DateTime.now
    @exam.verify_if_was_late
		apply_changes
	end

  def change_to_partial_released
    @exam.exam_status_kind = ExamStatusKinds::PARTIAL_RELEASED
    @exam.partial_released_report = exam_params[:partial_released_report]
    apply_changes
  end

  def initiate
    internal_code_ids = params[:exam][:internal_codes]
    if internal_code_ids.empty? == false
      @exam.internal_code_ids = [internal_code_ids.to_i]
    else
      @exam.internal_code_ids = nil
    end
    @exam.start_date = Date.today
    @exam.exam_status_kind = ExamStatusKinds::IN_PROGRESS
    apply_changes
  end

  def change_exam_status
    @exam.exam_status_kind_id = params[:new_status]
    apply_changes
  end

  private

  def apply_changes
    puts "------------------------------------"
    p params
    puts "************************************"
    p @exam
    puts "------------------------------------"
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
