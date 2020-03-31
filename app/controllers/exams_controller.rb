class ExamsController < ApplicationController
  include ChangeExamStatus
  include InstanceVariableSetter
  before_action :set_exam, only: [
                                  :initiate,
                                  :change_exam_status,
                                  :start,
                                  :completed,
                                  :edit,
                                  :update,
                                  :partial_released,
                                  :remove_report,
                                  :add_report,
                                  :change_to_partial_released,
                                  :save_exam_report,
                                  :reopen_exam
                                ]
  before_action :set_internal_codes, only: [:start, :edit]
  before_action :user_filter
  before_action :set_offered_exams, only: [:new, :edit]
  before_action :set_fields, only: [:new, :exams_from_patient]

  def new
    @exam = Exam.new(attendance_id: params[:id])
  end

  def create
    @exam = Exam.new(exam_params)
    if @exam.save
      flash[:success] = I18n.t :new_exam_success
    else
      flash[:warning] = @exam.errors.full_messages.first
    end
    redirect_to_exams_tab
  end

	def start
	end

	def edit
	end

	def update
    if @exam.update(exam_params)
			flash[:success] = I18n.t :edit_exam_success
		else
      flash[:warning] = @exam.errors.full_messages.first
		end
    redirect_to_exams_tab
	end

  # GET exams/1/partial_released
  def partial_released
  end

  # GET exams/1/add_report
  def add_report
  end

  # PATCH exams/1/save_exam_report
  def save_exam_report
    @exam.status = :complete
    if @exam.update exam_params
      flash[:success] = I18n.t :add_report_to_exam_success
      redirect_to_exams_tab
    else
      redirect_to add_report_path(@exam)
    end
  end

  def remove_report
    if params[:kind] == "partial_released"
      if @exam.update({status: :progress, partial_released_report: nil})
        flash[:success] = I18n.t :remove_report_success
      else
        flash[:error] = @exam.erros.complete_message.first
      end
    end
    redirect_to_exams_tab
  end

  def reopen_exam
    if @exam.reopen session[:user_id]
      flash[:success] = I18n.t :exam_reopen_success
    else
      flash[:error] = @exam.errors.full_messages.first
    end
    redirect_to_exams_tab
  end

  private

  	def exam_params
			params.require(:exam).permit(
        :offered_exam_id,
        :attendance,
        :internal_code_ids,
        :report,
        :partial_released_report,
        :attendance_id,
      )
  	end

    def set_exam
      @exam = Exam.includes(:offered_exam, :attendance).find params[:id]
    end

		def set_internal_codes
      internal_codes = @exam.attendance.internal_codes
      unless @exam.offered_exam.field == Field.BIOMOL
        @internal_codes = internal_codes
        return
      else
        internal_codes = internal_codes.joins(:subsample)
      end
			dna = internal_codes.where("subsamples.subsample_kind_id = ?", SubsampleKind.DNA.id).first
      rna = internal_codes.where("subsamples.subsample_kind_id = ?", SubsampleKind.RNA.id).first
      if dna && rna
        internal_code =  InternalCode.new(code: "#{dna.code}  -  #{rna.code}", id: nil)
        internal_codes = internal_codes.to_a << internal_code
      end
      @internal_codes = internal_codes
		end

    def set_offered_exams
      @offered_exams = OfferedExam
                                  .where(is_active: true)
                                  .where(field: session[:field_id])
                                  .order(name: :asc)
    end

    def redirect_to_exams_tab
      redirect_to attendance_path(@exam.attendance, {tab: "exams"})
    end

end
