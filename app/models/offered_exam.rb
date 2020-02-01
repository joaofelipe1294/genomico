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

  def self.from_field field
    self
        .where(field: field)
        .where(is_active: true)
  end

  def show_name
    return self.mnemonyc if self.mnemonyc != "" && self.mnemonyc
    self.name
  end

  private

    def default_params
    	self.is_active = true if self.is_active.nil?
    end

end
