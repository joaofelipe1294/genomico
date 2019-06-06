class HomeAdminController < ApplicationController
	before_action :admin_filter

  def index
  	@user = User.find(session[:user_id])
  end
end
