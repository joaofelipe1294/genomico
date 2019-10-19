module ExamsHelper
  include ExamStatusKinds

  def exam_options_helper exam
    @exam = exam
    @exam_status_kind = @exam.exam_status_kind
    options = ""
    return "".html_safe if @exam_status_kind == ExamStatusKinds::CANCELED
    is_in_progress = @exam_status_kind != ExamStatusKinds::COMPLETE_WITHOUT_REPORT && @exam_status_kind != ExamStatusKinds::COMPLETE
    if @exam_status_kind == ExamStatusKinds::WAITING_START
      options << start_exam_link
    elsif is_in_progress
      options << in_progress_options
    elsif  @exam_status_kind == ExamStatusKinds::COMPLETE_WITHOUT_REPORT
      options << add_report_link
    else
      options << complete_options
    end
    options << edit_link
    options << cancel_exam_link if @exam_status_kind != ExamStatusKinds::COMPLETE
    options.html_safe
  end

  private

    def tecnical_released_link
      link = ""
      unless @exam_status_kind == ExamStatusKinds::TECNICAL_RELEASED
        link = link(
          @exam,
          new_status: ExamStatusKinds::TECNICAL_RELEASED,
          css_class: 'secondary change-to-tecnical-released'
        )
      end
      link
    end

    def in_repeat_link
      link = ""
      unless @exam_status_kind == ExamStatusKinds::IN_REPEAT
        link = link(
          @exam,
          new_status: ExamStatusKinds::IN_REPEAT,
          css_class: 'warning change-to-in-repeat'
        )
      end
      link
    end

    def start_exam_link
      link_to(
        'Iniciar exame',
        start_exam_path(@exam),
        id: 'start-exam',
        class: 'btn btn-sm btn-outline-primary ml-3 start-exam'
        )
    end

    def partial_released_link
      link_to(
        'Liberado parcial',
        change_to_partial_released_path(@exam),
        class: 'btn btn-sm btn-outline-info ml-3 change-to-partial-released'
        )
    end

    def complete_link
      link = ""
      unless @exam_status_kind == ExamStatusKinds::COMPLETE || @exam_status_kind == ExamStatusKinds::COMPLETE_WITHOUT_REPORT
        link = link_to(
          'Concluído',
          change_to_completed_path(@exam),
          data: { confirm: "Tem certeza ?" },
          method: :patch,
          class: 'btn btn-sm btn-outline-success ml-3 change-to-complete'
          )
      end
      link
    end

    def link(exam, new_status: nil, css_class: "", method: "patch")
      link_to(
        new_status.name,
        change_exam_status_path(exam, {new_status: new_status}),
        method: method,
        class: "btn btn-sm ml-3 btn-outline-#{css_class}"
      )
    end

    def edit_link
      link_to(
        'Editar',
        edit_exam_path(@exam),
        class: 'btn btn-sm btn-warning ml-2 edit-exam'
      )
    end

    def add_report_link
      link_to(
        'Adicionar laudo',
        add_report_to_exam_path(@exam),
        class: 'ml-3 add-report'
        )
    end

    def in_progress_options
      options = ""
      options << tecnical_released_link
      options << in_repeat_link
      options << partial_released_link
      options << complete_link
      options
    end

    def cancel_exam_link
      link_to(
        "Cancelar",
        change_exam_status_path(@exam, {new_status: ExamStatusKinds::CANCELED}),
        data: { confirm: "Tem certeza ?" },
        method: :patch,
        class: "btn btn-sm btn-outline-danger cancel-exam ml-3"
      )
    end

    def complete_options
      options = ""
      options << "<label class = 'text-success ml-3'>Exame concluído</label>".html_safe
      options << link_to(
        'Visualizar laudo',
        add_report_to_exam_path(@exam),
        class: 'btn btn-sm btn-info see-report ml-3'
        )
      options
    end

end
