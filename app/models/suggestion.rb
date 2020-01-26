class Suggestion < ApplicationRecord
  belongs_to :requester, class_name: :User
  validates_presence_of :title, :description, :requester, :current_status, :kind
  validates_uniqueness_of :title
  before_validation :set_default_status
  has_many :suggestion_progresses
  enum current_status: {
    in_line: 0,
    evaluating: 1,
    in_progress: 2,
    waiting_validation: 3,
    complete: 4,
    canceled: 5
  }
  enum kind: {
    bug: 0,
    new_feature: 1,
    upgrade_feature: 2
  }

  private

    def set_default_status
      self.current_status = :in_line unless self.current_status
    end

end
