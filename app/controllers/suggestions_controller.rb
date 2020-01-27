class SuggestionsController < ApplicationController
  include InstanceVariableSetter
  before_action :user_filter

  def index
  end

  def new
    @suggestion = Suggestion.new({
      kind: params[:kind]
      })
      set_users
  end

  def create
    @suggestion = Suggestion.new suggestion_params
    if @suggestion.save
      flash[:success] = I18n.t :new_suggestion_success
      redirect_to suggestions_path
    else
      set_users
      render :new
    end
  end

  def edit
  end

  private

    def suggestion_params
      params.require(:suggestion).permit(:title, :description, :kind, :requester_id)
    end

end
