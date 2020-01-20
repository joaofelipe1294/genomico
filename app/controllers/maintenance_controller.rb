class MaintenanceController < ApplicationController
  def maintenance
    return redirect_to root_path unless ActionController::Base.cache_store.read("maintenance")
  end
end
