class SuggestionsController < ApplicationController
  include InstanceVariableSetter
  before_action :user_filter, only: [:new, :create, :edit]
  before_action :set_users, only: [:new, :edit, :create, :update]
  before_action :set_suggestion, only: [:edit, :update, :complete, :show]
  before_action :filter_suggestions, only: [:index]
  before_action :shared_filter, only: [:index, :update]

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
    return update_using_path_params if params[:current_status].present?
    if @suggestion.update suggestion_params
      flash[:success] = I18n.t :edit_suggestion_success
      redirect_to suggestions_path
    else
      render :edit
    end
  end

  def index_admin
  end

  def show
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
      elsif params[:from_user].present?
        suggestions = Suggestion.from_user current_user
      else
        suggestions = Suggestion.all
      end
      @suggestions = suggestions.includes(:requester).order(created_at: :asc).page params[:page]
    end

    def update_using_path_params
      if @suggestion.update current_status: params[:current_status]
        flash[:success] = I18n.t :edit_suggestion_success
      else
        flash[:error] = @suggestion.errors.full_messages.first
      end
      redirect_to suggestions_path
    end

end
