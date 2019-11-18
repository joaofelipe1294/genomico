class Release < ApplicationRecord
  validates :name, :tag, :message, presence: true
  validates :name, :tag, presence: true
  before_validation :set_is_active

  private

    def set_is_active
      self.is_active = true if self.is_active.nil?
    end

end
