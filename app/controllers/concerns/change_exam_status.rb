module ChangeExamStatus
  extend ActiveSupport::Concern

  def completed
		@exam.status = :complete_without_report
		@exam.finish_date = DateTime.now
    @exam.verify_if_was_late
		apply_changes
	end

  def change_to_partial_released
    @exam.status = :partial_released
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
    @exam.status = :progress
    apply_changes
  end

  def change_exam_status
    @exam.status = params[:new_status]
    apply_changes
  end

  private

  def apply_changes
    if @exam.change_status session[:user_id]
      flash[:success] = "Status de exame alterado para #{@exam.status_name}."
      return redirect_to add_report_to_exam_path(@exam) if @exam.complete_without_report?
    else
      flash[:error] = @exam.erros.first.complete_message
    end
    redirect_to_exams_tab
  end

end
