class Suggestion < ApplicationRecord
  belongs_to :requester, class_name: :User
  validates_presence_of :title, :description, :requester, :current_status, :kind
  validates_uniqueness_of :title
  before_validation :set_default_status
  has_many :suggestion_progresses
  paginates_per 12
  enum current_status: {
    in_line: 0,
    evaluating: 1,
    in_progress: 2,
    waiting_validation: 3,
    complete: 4,
    canceled: 5
  }
  after_create :generate_initial_progress
  enum kind: {
    bug_report: 0,
    new_feature: 1,
    feature_improvement: 2
  }

  def change_status new_status, user
    generate_new_suggestion_progress(user) if self.update(current_status: new_status)
  end

  private

    def set_default_status
      self.current_status = :in_line unless self.current_status
    end

    def generate_initial_progress
      SuggestionProgress.create({
        old_status: nil,
        new_status: :in_line,
        responsible: self.requester,
        suggestion: self
        })
    end

    def generate_new_suggestion_progress user
      SuggestionProgress.create({
        old_status: self.current_status_before_last_save,
        new_status: self.current_status,
        suggestion: self,
        responsible: user
        })
    end

end
