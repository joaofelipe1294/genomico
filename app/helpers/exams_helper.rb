module ExamsHelper

  def show_exam_status exam
    color = {
      waiting_start: :dark,
      progress: :primary,
      in_repeat: :warning,
      complete_without_report: :info,
      partial_released: :secondary,
      complete: :success,
    }
    %Q(<span class="text-#{color[exam.status.to_sym]}">#{exam.status_name}</span>).html_safe
  end

  def exam_options_helper exam
    @exam = exam
    options = ""
    return "".html_safe if @exam.canceled?
    is_in_progress = @exam.complete_without_report? == false && @exam.complete? == false
    if @exam.waiting_start?
      options << start_exam_link
      options << edit_link
    elsif is_in_progress
      options << in_progress_options
      options << edit_link
    elsif  @exam.complete_without_report?
      options << add_report_link
    else
      options << complete_options
    end
    options << cancel_exam_link unless @exam.complete?
    options.html_safe
  end

  private

    def tecnical_released_link
      link = ""
      unless @exam.tecnical_released?
        link = link(
          @exam,
          new_status: :tecnical_released,
          css_class: 'secondary change-to-tecnical-released'
        )
      end
      link
    end

    def in_repeat_link
      link = ""
      unless @exam.in_repeat?
        link = link(
          @exam,
          new_status: :in_repeat,
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
      unless @exam.complete? || @exam.complete_without_report?
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
        Exam.status_name(new_status),
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
        change_exam_status_path(@exam, {new_status: :canceled}),
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
      options << link_to(
        "Reabrir exame",
        reopen_exam_path(@exam),
        method: :patch,
        data: { confirm: "Tem certeza ?" },
        class: 'btn btn-sm btn-outline-danger ml-3 reopen-exam'
      )
      options
    end

end
