module SuggestionsHelper

  SUGGESTION_OPTIONS = {
    new_feature: {name: "Nova funcionalidade", color: "primary"},
    bug_report: {name: "Bug report", color: "danger"},
    feature_improvement: {name: "Nova melhoria", color: "info"}
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
      <button class='btn btn-outline-#{suggestion_config[:color]}'>
        Salvar
      </button>
    ).html_safe
  end

end
