class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :exam_status_color_helper

  def admin_filter
      user = User.find_by({
        id: session[:user_id],
        login: session[:user_login],
        user_kind: UserKind.ADMIN,
        is_active: true
      })
      if user.nil?
        reset_session
        flash[:warning] = I18n.t :wrong_credentials_message
        redirect_to root_path
      end
    end

    def user_filter
      user = User.find_by({
        id: session[:user_id],
        login: session[:user_login],
        user_kind: UserKind.USER,
        is_active: true
      })
      if user.nil?
        reset_session
        flash[:warning] = I18n.t :wrong_credentials_message
        redirect_to root_path
      end
    end

    def generic_filter
      user = User.find_by({
        id: session[:user_id],
        login: session[:user_login],
      })
      if user.nil?
        reset_session
        flash[:warning] = I18n.t :wrong_credentials_message
        redirect_to root_path
      end
    end

    def redirect_to_home
      if User.find(session[:user_id]).user_kind == UserKind.ADMIN
        redirect_to home_admin_index_path
      else
        redirect_to home_user_index_path
      end
    end

end
