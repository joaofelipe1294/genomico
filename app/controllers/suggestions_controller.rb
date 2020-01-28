class SuggestionsController < ApplicationController
  include InstanceVariableSetter
  before_action :user_filter, only: [:index, :new, :create, :edit, :update]
  before_action :set_users, only: [:new, :edit, :create, :update]
  before_action :set_suggestion, only: [:edit, :update, :development, :change_to_development]
  before_action :admin_filter, only: [:index_admin, :development, :change_to_development]
  before_action :filter_suggestions, only: [:index, :index_admin]
  before_action :set_user, only: [:change_status, :change_to_development]

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
    if @suggestion.change_status params[:new_status], @user
      flash[:success] = I18n.t :suggest_status_change_success
    end
    if @user.user_kind == UserKind.USER
      redirect_to suggestions_path
    else
      redirect_to suggestions_index_admin_path
    end
  end

  def index_admin
  end

  def development
  end

  def change_to_development
    if @suggestion.change_to_development(@user, suggestion_params[:time_forseen])
      flash[:success] = I18n.t :suggestion_change_to_development_success
      redirect_to suggestions_index_admin_path(kind: :in_progress)
    else
      flash[:warning] = @suggestion.errors.full_messages.first
      redirect_to suggestions_index_admin_path(kind: :in_line)
    end
  end

  private

    def set_suggestion
      @suggestion = Suggestion.find params[:id]
    end

    def set_user
      @user = User.find session[:user_id]
    end

    def suggestion_params
      params.require(:suggestion).permit(:title, :description, :kind, :requester_id, :time_forseen)
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
