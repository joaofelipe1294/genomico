class HomeUserController < ApplicationController
  before_action :user_filter

  def index
    @user = User.includes(:fields).find session[:user_id]
    @report = HomeUserReport.new({field: @user.field})
    @offered_exams = OfferedExam.from_field(@user.field).order name: :asc
    @issues = @report.find_issues filter_by: params
  end

end
