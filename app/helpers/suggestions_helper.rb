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
      in_progress: {name: "Em desenvolvimento", color: "info"},
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

end
