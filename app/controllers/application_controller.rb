class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :exam_status_color_helper

  def admin_filter
      user = find_user UserKind.ADMIN
      wrong_credentials_redirect unless user
    end

    def user_filter
      user = find_user UserKind.USER
      if user
        check_release_message
      else
        wrong_credentials_redirect
      end
    end

    def generic_filter
      admin = find_user UserKind.ADMIN
      user = find_user UserKind.USER
      wrong_credentials_redirect unless user || admin
    end

    def redirect_to_home
      if User.find(session[:user_id]).user_kind == UserKind.ADMIN
        redirect_to home_admin_index_path
      else
        redirect_to home_user_index_path
      end
    end

    private

    def wrong_credentials_redirect
      reset_session
      flash[:warning] = I18n.t :wrong_credentials_message
      redirect_to root_path
    end

    def find_user user_kind
      User.find_by({
        id: session[:user_id],
        login: session[:user_login],
        user_kind: user_kind,
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

end
