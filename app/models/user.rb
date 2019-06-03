class User < ActiveRecord::Base
  belongs_to :user_kind
  has_secure_password
  validates :login, uniqueness: true
  validates :login, :password, :name, :user_kind_id, presence: true
end
