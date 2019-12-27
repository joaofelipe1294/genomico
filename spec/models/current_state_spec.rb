require 'rails_helper'

RSpec.describe CurrentState, type: :model do

  it "complete" do
    current_state = build(:current_state)
    expect(current_state).to be_valid
  end

  it "without name" do
    current_state = build(:current_state, name: "")
    expect(current_state).to be_invalid
  end

  it "duplicated name" do
    current_state = create(:current_state)
    duplicated = build(:current_state, name: current_state.name)
    expect(duplicated).to be_invalid
  end

  context "" do

    before(:each) { Rails.application.load_seed }

    it "stock" do
      expect(CurrentState.STOCK).to eq CurrentState.find_by name: "Estoque"
    end

    it "in_use" do
      expect(CurrentState.IN_USE).to eq CurrentState.find_by name: "Em uso"
    end

    it "out" do
      expect(CurrentState.OUT).to eq CurrentState.find_by name: "Concluído"
    end

  end




end
