class SuggestionsController < ApplicationController
  include InstanceVariableSetter
  before_action :user_filter, only: [:index, :new, :create, :edit, :update, :change_to_complete]
  before_action :set_users, only: [:new, :edit, :create, :update]
  before_action :set_suggestion, only: [:edit, :update, :development, :change_to_development, :complete, :show]
  before_action :admin_filter, only: [:index_admin, :development, :change_to_development]
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
    if @suggestion.change_status params[:new_status], current_user
      flash[:success] = I18n.t :suggest_status_change_success
    end
    if current_user.user_kind == UserKind.USER
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
    if @suggestion.change_to_development(current_user, suggestion_params[:time_forseen])
      flash[:success] = I18n.t :suggestion_change_to_development_success
      redirect_to suggestions_index_admin_path(kind: :in_progress)
    else
      flash[:warning] = @suggestion.errors.full_messages.first
      redirect_to suggestions_index_admin_path(kind: :in_line)
    end
  end

  def complete
    if @suggestion.change_to_complete
      flash[:success] = I18n.t :success
    else
      flash[:warning] = model.errors.full_messages.first
    end
    redirect_to suggestions_path
  end

  def show
  end

  private

    def set_suggestion
      @suggestion = Suggestion.find params[:id]
    end

    def suggestion_params
      params.require(:suggestion).permit(:title, :description, :kind, :requester_id, :time_forseen)
    end

    def filter_suggestions
      kind = params[:kind]
      if kind
        suggestions = SuggestionFinderService.new(kind).call
      elsif params[:from_user].present?
        suggestions = Suggestion.from_user current_user
      else
        suggestions = Suggestion.all
      end
      @suggestions = suggestions.includes(:requester).order(created_at: :desc).page params[:page]
    end

end
