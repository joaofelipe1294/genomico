module SuggestionsHelper

  SUGGESTION_OPTIONS = {
    new_feature: {name: "Funcionalidade", color: "primary"},
    bug_report: {name: "Bug report", color: "danger"},
    feature_improvement: {name: "Melhoria", color: "info"}
  }

  def suggestion_header suggestion
    %Q(
      <div class='card-header bg-#{SUGGESTION_OPTIONS[suggestion.kind.to_sym][:color]}'>
        <h4 class='text-center text-white'>
          #{SUGGESTION_OPTIONS[suggestion.kind.to_sym][:name]}
        </h4>
      </div>
    ).html_safe
  end

  def suggestion_button suggestion
    %Q(
      <button class='btn btn-outline-#{SUGGESTION_OPTIONS[suggestion.kind.to_sym][:color]}' id='btn-save'>
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

end
