module DeseaseStage
  extend ActiveSupport::Concern

  module ClassMethods

    def desease_stages_for_select
      desease_stages.map do |desease_stage, _|
        [ I18n.t("enums.attendance.desease_stages.#{desease_stage}"), desease_stage ]
      end
    end

  end

  ActiveRecord::Base::enum desease_stage:  {
    diagnosis: 1,
    relapse: 2,
    drm: 3,
    subpop: 4,
    subpop_ret: 5,
    immmune_profile: 6
  }

  def desease_stage_name
    I18n.t("enums.attendance.desease_stages.#{self.status}")
  end

end
