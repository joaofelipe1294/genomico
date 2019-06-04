class HomeController < ApplicationController
  def index
  end

  def login
  	user = User.find_by({login: user_params[:login]})
  	if user
	  	if user.authenticate user_params[:password]
	  		session[:user_id] = user.id
        session[:user_login] = user.login
	  		redirect_to home_admin_index_path if user.user_kind == UserKind.find_by({name: 'admin'}) 
	  		redirect_to root_path if user.user_kind == UserKind.find_by({name: 'user'})
			else
				flash[:error] = 'Login ou senha inválidos.'
				redirect_to root_path
			end
		else
			flash[:error] = 'Login ou senha inválidos.'
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