class HomeController < ApplicationController
  def index
  end

  def login
  	user = User.find_by({login: user_params[:login]})
  	unless user.nil?
	  	if user.authenticate user_params[:password]
	  		session[:user_id] = user.id
        session[:user_login] = user.login
        session[:field_id] = user.fields.first.id
	  		redirect_to home_admin_index_path if user.user_kind == UserKind.ADMIN
	  		redirect_to home_user_index_path if user.user_kind == UserKind.USER
			else
				flash[:warning] = I18n.t :wrong_login_message
				redirect_to root_path
			end
		else
			flash[:warning] = I18n.t :wrong_login_message
			redirect_to root_path
		end
  end

  def logout
  	reset_session
  	redirect_to root_path
  end

  private

  def user_params
  	params.permit(:login, :password)
  end

end
