class Subsample < ActiveRecord::Base
  validates :sample, :subsample_kind, presence: true
  belongs_to :sample
  belongs_to :attendance
  belongs_to :subsample_kind
  has_one :qubit_report, dependent: :destroy
  has_one :nanodrop_report, dependent: :destroy
  has_one :hemacounter_report, dependent: :destroy
  accepts_nested_attributes_for :qubit_report, allow_destroy: true
  accepts_nested_attributes_for :nanodrop_report, allow_destroy: true
  accepts_nested_attributes_for :hemacounter_report, allow_destroy: true
  before_save :add_default_values
  has_many :internal_codes
  belongs_to :patient
  after_create :generate_internal_code

  private

    def add_default_values
      self.refference_label = SubsampleLabelGeneratorService.new(self).call unless self.refference_label
      self.collection_date = DateTime.now
  		self.sample.update({has_subsample: true})
      self.attendance = sample.attendance
      self.patient = self.attendance.patient unless self.patient
    end

    def generate_internal_code
      if self.subsample_kind == SubsampleKind.PELLET
        InternalCode.create({
          field: Field.FISH,
          subsample: self,
        })
      else
        InternalCode.create(
          field: Field.BIOMOL,
          subsample: self
        )
      end
    end

end
