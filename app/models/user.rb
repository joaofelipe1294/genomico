class User < ActiveRecord::Base
  belongs_to :user_kind
  has_secure_password
  validates :login, :name, uniqueness: true
  validates :login, :name, :user_kind_id, presence: true
  after_initialize :default_values
  has_and_belongs_to_many :fields
  has_many :release_checks
  enum kind: {
    user: 1,
    admin: 2
  }

  def field
    self.fields.first
  end

  private

  def default_values
    self.is_active = true if self.is_active.nil?
  end


end
