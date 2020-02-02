module InstanceVariableSetter
  extend ActiveSupport::Concern

  def set_fields
    @fields = Field.all.order name: :asc
  end

  def set_subsample_kinds
    @subsample_kinds = SubsampleKind.all.order name: :asc
  end

  def set_sample_kinds
    @sample_kinds = SampleKind.all.order name: :asc
  end

  def set_hospitals
    @hospitals = Hospital.all.order :name
  end

  def set_current_states
    @current_states = CurrentState.all.order(:name)
  end

  def set_users
    @users = User.where(kind: :user).order(:login)
  end

  def set_health_ensurances
    @health_ensurances = HealthEnsurance.all.order :name
  end

end
