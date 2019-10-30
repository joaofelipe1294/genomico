class OfferedExamGroup < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  has_many :offered_exams

  def self.IMUNOFENO
    OfferedExamGroup.find_by name: "Imunofenotipagem"
  end

  def self.FISH
    OfferedExamGroup.find_by name: "FISH"
  end

  def self.NGS
    OfferedExamGroup.find_by name: "NGS"
  end

  def self.PCR
    OfferedExamGroup.find_by name: "PCR e qPCR"
  end

  def self.SEQUENCING
    OfferedExamGroup.find_by name: "Sequenciamento"
  end

end
