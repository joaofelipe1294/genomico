class SuggestionFinderService

  def initialize filter_by
    @filter_by = filter_by
  end

  def call
    if @filter_by == "in_progress"
      Suggestion.in_progress
    elsif @filter_by == "in_line"
      Suggestion.in_line
    else
      Suggestion.complete
    end
  end

end
