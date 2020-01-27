class SuggestionsController < ApplicationController
  include InstanceVariableSetter
  before_action :user_filter

  def index
    if params[:kind].present?
      if params[:kind] == "in-progress"
        @suggestions = Suggestion
                                .includes(:requester)
                                .where.not(current_status: [:canceled, :complete])
                                .order(:created_at)
      end
    end
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
    @suggestion = Suggestion.find params[:id]
    set_users
  end

  private

    def suggestion_params
      params.require(:suggestion).permit(:title, :description, :kind, :requester_id)
    end

end
