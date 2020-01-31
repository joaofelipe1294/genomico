class User < ActiveRecord::Base
  has_secure_password
  validates_uniqueness_of :login, :name
  validates_presence_of :login, :name, :kind
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

  def self.kinds_for_select
    kinds.map do |kind, _|
      [
        I18n.t("activerecord.attributes.#{model_name.i18n_key}.kinds.#{kind}"),
        kind
      ]
    end
  end

  private

  def default_values
    self.is_active = true unless self.is_active
  end

end
