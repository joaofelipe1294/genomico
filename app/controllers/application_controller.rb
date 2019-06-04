class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def admin_filter
      user = User.find_by({
        id: session[:user_id],
        login: session[:user_login],
        user_kind: UserKind.find_by({name: 'admin'})
      })
      if user.nil?
        reset_session
        flash[:warning] = 'Credenciais inválidas.'
        redirect_to root_path
      end
    end

end
