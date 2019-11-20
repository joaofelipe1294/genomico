class Release < ApplicationRecord
  validates :name, :tag, :message, presence: true
  validates :name, :tag, uniqueness: true
  before_validation :set_is_active
  has_many :release_checks
  after_create :add_release_checks

  private

    def set_is_active
      self.is_active = true if self.is_active.nil?
    end

    def add_release_checks
      users = User
                  .where(user_kind: UserKind.USER)
                  .where(is_active: true)
      users.each do |user|
        ReleaseCheck.create({
          user: user,
          release: self,
          has_confirmed: false
        })
      end
    end

end
