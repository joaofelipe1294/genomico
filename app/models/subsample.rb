class Subsample < ActiveRecord::Base
  validates :sample, :subsample_kind, presence: true
  belongs_to :sample
  belongs_to :attendance
  belongs_to :subsample_kind
  has_one :qubit_report, dependent: :destroy
  has_one :nanodrop_report, dependent: :destroy
  accepts_nested_attributes_for :qubit_report, allow_destroy: true
  accepts_nested_attributes_for :nanodrop_report, allow_destroy: true
  before_save :add_default_values
  has_many :internal_codes
  belongs_to :patient

  private

    def add_default_values
      if self.refference_label.nil?

        index = Subsample.where(subsample_kind: self.subsample_kind).size
        if self.subsample_kind == SubsampleKind.VIRAL_DNA
          index += 828
        elsif self.subsample_kind == SubsampleKind.RNA
          index += 311
        elsif self.subsample_kind == SubsampleKind.DNA
          index += 419
        elsif self.subsample_kind == SubsampleKind.PELLET
          index += 226
        end

    		self.refference_label = "#{Date.today.year.to_s.slice(2, 3)}-#{subsample_kind.acronym}-#{index.to_s.rjust(4,  "0")}"
      end
      self.collection_date = DateTime.now
  		self.sample.update({has_subsample: true})
      self.attendance = sample.attendance
      self.patient = self.attendance.patient if self.patient.nil?
    end

end
