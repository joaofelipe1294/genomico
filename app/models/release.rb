class Release < ApplicationRecord
  validates_presence_of :name, :tag, :message
  validates_uniqueness_of :name, :tag
  before_validation :set_is_active
  has_many :release_checks
  after_create :add_release_checks

  private

    def set_is_active
      self.is_active = true unless self.is_active
    end

    def add_release_checks
      users = User.where(kind: :user).where(is_active: true)
      users.each do |user|
        ReleaseCheck.create({
          user: user,
          release: self,
          has_confirmed: false
        })
      end
    end

end
