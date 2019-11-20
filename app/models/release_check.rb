class ReleaseCheck < ApplicationRecord
  belongs_to :user
  belongs_to :release
  before_validation :set_has_confirmed

  private

  def set_has_confirmed
    self.has_confirmed = false if self.has_confirmed.nil?
  end

end
