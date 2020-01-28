module SuggestionsHelper

  SUGGESTION_OPTIONS = {
    new_feature: {name: "Funcionalidade", color: "primary"},
    bug_report: {name: "Bug report", color: "danger"},
    feature_improvement: {name: "Melhoria", color: "info"}
  }

  def suggestion_header suggestion
    suggestion_config = SUGGESTION_OPTIONS[suggestion.kind.to_sym]
    %Q(
      <div class='card-header bg-#{suggestion_config[:color]}'>
        <h4 class='text-center text-white'>
          #{suggestion_config[:name]}
        </h4>
      </div>
    ).html_safe
  end

  def suggestion_button suggestion
    suggestion_config = SUGGESTION_OPTIONS[suggestion.kind.to_sym]
    %Q(
      <button class='btn btn-outline-#{suggestion_config[:color]}' id='btn-save'>
        Salvar
      </button>
    ).html_safe
  end

  def show_current_state suggestion
    states_hash = {
      in_line: {name: "Na fila", color: "dark"},
      evaluating: {name: "Em análise", color: "secondary"},
      development: {name: "Em desenvolvimento", color: "info"},
      waiting_validation: {name: "Aguardando validação", color: "primary"},
      complete: {name: "Concluído", color: "success"},
      canceled: {name: "Cancelado", color: "danger"}
    }
    state = states_hash[suggestion.current_status.to_sym]
    %Q(
      <span class="text-#{state[:color]}">
        #{state[:name]}
      </span>
    ).html_safe
  end

  def show_suggestion_kind suggestion
    suggestion_config = SUGGESTION_OPTIONS[suggestion.kind.to_sym]
    %Q(
      <span class="text-#{suggestion_config[:color]}">
        #{suggestion_config[:name]}
      </span>
    ).html_safe
  end

  def show_time_forseen suggestion
    time_forseen = suggestion.time_forseen
    if time_forseen
      "#{time_forseen} (Horas)"
    else
      "-"
    end
  end

  def in_progress_suggestions_bedge
    %Q(
      <span class="badge badge-dark">#{Suggestion.in_progress.size}</span>
    ).html_safe
  end

  def in_line_suggestions_bedge
    %Q(
      <span class="badge badge-primary" title="Novas funcionalidades">#{Suggestion.where(current_status: :in_line).where(kind: :new_feature).size}</span>
      <span class="badge badge-danger" title="Bugs encontrados">#{Suggestion.where(current_status: :in_line).where(kind: :bug_report).size}</span>
      <span class="badge badge-info" title="Melhorias">#{Suggestion.where(current_status: :in_line).where(kind: :feature_improvement).size}</span>
    ).html_safe
  end

  def suggestions_from_user_bedge
    current_user = User.find session[:user_id]
    suggestions = Suggestion.from_user current_user
    in_line = suggestions.where(current_status: :in_line).size
    evaluating = suggestions.where(current_status: :evaluating).size
    development = suggestions.where(current_status: :development).size
    waiting_validation = suggestions.where(current_status: :waiting_validation).size
    bedges = ""
    bedges << "<span class='badge badge-light mr-1' text='Em espera'>#{in_line}</span>" if in_line > 0
    bedges << "<span class='badge badge-secondary mr-1' text='Em avaliação'>#{evaluating}</span>" if evaluating > 0
    bedges << "<span class='badge badge-info mr-1' text='Em desenvolvimento'>#{development}</span>" if development > 0
    bedges << "<span class='badge badge-primary' text='Aguardando validação'>#{waiting_validation}</span>" if waiting_validation > 0
    bedges.html_safe
  end

  def suggestions_complete_bedge
    %Q(
      <span class="badge badge-success">#{Suggestion.complete.size}</span>
    ).html_safe
  end

end
