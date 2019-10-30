class OfferedExam < ActiveRecord::Base
  belongs_to :field
  belongs_to :offered_exam_group
  has_many :exams
  validates :name, uniqueness: true
  validates :name, :field, :refference_date, presence: true
  after_initialize :default_params
  paginates_per 10
  validates_with MnemonycUniquenessCheck

  def show_name
    return self.mnemonyc if self.mnemonyc != "" && self.mnemonyc
    self.name
  end

  private

    def default_params
    	self.is_active = true if self.is_active.nil?
    end

end
