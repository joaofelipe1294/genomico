require 'rails_helper'

RSpec.describe UnitOfMeasurement, type: :model do

  it "complete" do
    unit_of_measurement = build(:unit_of_measurement, name: "Caixa")
    expect(unit_of_measurement).to be_valid
  end

  it "without name" do
    unit_of_measurement = build(:unit_of_measurement, name: "")
    expect(unit_of_measurement).to be_invalid
  end

  it "duplicated name" do
    original_unit_of_measurement = create(:unit_of_measurement, name: "Kits")
    duplicated = build(:unit_of_measurement, name: original_unit_of_measurement.name)
    expect(duplicated).to be_invalid
  end

end
