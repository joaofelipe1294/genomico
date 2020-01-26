module SuggestionStatuses
  extend ActiveSupport::Concern

  module ClassMethods

    def statuses
      {
        in_line: 0,
        evaluating: 1,
        in_progress: 2,
        waiting_validation: 3,
        complete: 4,
        canceled: 5
      }
    end
  end

end
