class HomeController < ApplicationController

  def index
  end

  def login
    @user = authenticate_user
  	if @user
      set_navbar_data
		  set_user_credentials
  		redirect_to home_admin_index_path if @user.admin?
  		redirect_to home_user_index_path if @user.user?
		else
			flash[:warning] = I18n.t :wrong_login_message
			redirect_to root_path
		end
  end

  def logout
  	reset_session
  	redirect_to root_path
  end

  def status
    status_service = StatusService.new
    render json: status_service.call(), status: :ok
  end

  private

    def set_user_credentials
      @user.update(last_login_at: DateTime.current)
      session[:user_id] = @user.id
      session[:user_login] = @user.login
      user_fields = @user.fields
      session[:field_id] = user_fields.first.id if @user.user? && user_fields.empty? == false
    end

    def authenticate_user
      login = user_params[:login]
      user = User.find_by({login: login})
    	return nil unless user
      return user if user.authenticate user_params[:password]
      nil
    end

    def user_params
    	params.permit(:login, :password)
    end

    def set_navbar_data
      session[:indicators] = {
        PCR: OfferedExamGroup.PCR.id,
        NGS: OfferedExamGroup.NGS.id,
        SEQUENCING: OfferedExamGroup.SEQUENCING.id,
        IMUNOFENO: OfferedExamGroup.IMUNOFENO.id,
        FISH: OfferedExamGroup.FISH.id
      }
    end

end
