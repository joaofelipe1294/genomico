class OfferedExam < ActiveRecord::Base
  belongs_to :field
  has_many :exams
  validates_uniqueness_of :name, uniqueness: true
  validates_presence_of :name, :field, :refference_date, :group
  after_initialize :default_params
  paginates_per 10
  validates_with MnemonycUniquenessCheck
  enum group: {
    imunofeno: 1,
    fish: 2,
    ngs: 3,
    pcr: 4,
    sequencing: 5
  }

  def self.groups_for_select
    groups.map do |group, _|
      [ I18n.t("enums.offered_exam.groups.#{group}"), group ]
    end
  end

  def desease_stage_name
    I18n.t("enums.offered_exam.groups.#{self.group}")
  end

  def self.from_field field
    self.where(field: field).where(is_active: true)
  end

  def show_name
    return self.mnemonyc if self.mnemonyc != "" && self.mnemonyc
    self.name
  end

  def self.group_name group
    I18n.t("enums.offered_exam.groups.#{group}")
  end

  def self.by_field field
    self.where(field: field).where(is_active: true).order(:name)
  end

  private

    def default_params
    	self.is_active = true if self.is_active.nil?
    end

end
