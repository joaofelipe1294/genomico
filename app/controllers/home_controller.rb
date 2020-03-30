class HomeController < ApplicationController
  before_action :shared_filter, only: [:logged_in]
  before_action :check_release_message, only: [:logged_in]

  def index
  end

  def login
    @user = authenticate_user
  	if @user
		  set_user_credentials
  	  redirect_to home_path
		else
			flash[:warning] = I18n.t :wrong_login_message
			redirect_to root_path
		end
  end

  def logged_in
    if current_user.user?
      @user = User.includes(:fields).find session[:user_id]
      @report = HomeUserReport.new({field: @user.field})
      @offered_exams = OfferedExam.from_field(@user.field).order name: :asc
      @issues = @report.find_issues filter_by: params
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
      return nil unless user.is_active
      return user if user.authenticate user_params[:password]
      nil
    end

    def user_params
    	params.permit(:login, :password)
    end

end
