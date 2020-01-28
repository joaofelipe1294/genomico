class SuggestionsController < ApplicationController
  include InstanceVariableSetter
  before_action :user_filter, except: [:index_admin]
  before_action :set_users, only: [:new, :edit, :create, :update]
  before_action :set_suggestion, only: [:edit, :update]
  before_action :admin_filter, only: [:index_admin]
  before_action :filter_suggestions, only: [:index, :index_admin]

  def index
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
    @suggestion = Suggestion.find params[:suggestion_id]
    if @suggestion.change_status params[:new_status], User.find(session[:user_id])
      flash[:success] = I18n.t :suggest_status_change_success
    end
    redirect_to suggestions_path
  end

  def index_admin
  end

  private

    def set_suggestion
      @suggestion = Suggestion.find params[:id]
    end

    def suggestion_params
      params.require(:suggestion).permit(:title, :description, :kind, :requester_id)
    end

    def filter_suggestions
      kind = params[:kind]
      if kind
        suggestions = SuggestionFinderService.new(kind).call
      else
        suggestions = Suggestion.includes(:requester).all
      end
      @suggestions = suggestions.order(:id).page params[:page]
    end

end
