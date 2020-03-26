class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :exam_status_color_helper
  before_action :check_maintenance_status, except: [:maintenance]
  helper_method :current_user

  def admin_filter
    user = find_user :admin
    wrong_credentials_redirect unless user
  end

  def user_filter
    user = find_user :user
    if user
      check_release_message
    else
      wrong_credentials_redirect
    end
  end

  def current_user
    User.includes(:fields).find session[:user_id]
  end

  def shared_filter
    wrong_credentials_message unless session[:user_id]
  end

  private

    def wrong_credentials_redirect
      reset_session
      flash[:warning] = I18n.t :wrong_credentials_message
      redirect_to root_path
    end

    def find_user kind
      User.find_by({
        id: session[:user_id],
        login: session[:user_login],
        kind: kind,
        is_active: true
      })
    end

    def check_release_message
      user = User.find session[:user_id]
      unless user.release_checks.where(has_confirmed: false).empty?
        @has_release_message = true
      else
        @has_release_message = false
      end
    end

    def check_maintenance_status
      return redirect_to maintenance_path if ActionController::Base.cache_store.read("maintenance")
    end

end
