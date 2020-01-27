class SuggestionsController < ApplicationController
  include InstanceVariableSetter
  before_action :user_filter
  before_action :set_users, only: [:new, :edit, :create, :update]
  before_action :set_suggestion, only: [:edit, :update]

  def index
    if params[:kind].present?
      if params[:kind] == "in-progress"
        @suggestions = Suggestion
                                .includes(:requester)
                                .where.not(current_status: [:canceled, :complete])
                                .order(:created_at)
                                .page params[:page]
        else
          @suggestions = Suggestion
                                  .includes(:requester)
                                  .order(:created_at)
                                  .page params[:page]
      end
    else
      @suggestions = Suggestion
                              .includes(:requester)
                              .order(:created_at)
                              .page params[:page]
    end
  end

  def new
    @suggestion = Suggestion.new({
      kind: params[:kind]
      })
  end

  def create
    @suggestion = Suggestion.new suggestion_params
    if @suggestion.save
      flash[:success] = I18n.t :new_suggestion_success
      redirect_to suggestions_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @suggestion.update suggestion_params
      flash[:success] = I18n.t :edit_suggestion_success
      redirect_to suggestions_path
    else
      render :edit
    end
  end

  def change_status
    # code
  end

  private

    def set_suggestion
      @suggestion = Suggestion.find params[:id]
    end

    def suggestion_params
      params.require(:suggestion).permit(:title, :description, :kind, :requester_id)
    end

end
