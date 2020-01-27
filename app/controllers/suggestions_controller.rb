class SuggestionsController < ApplicationController
  include InstanceVariableSetter

  def index
  end

  def new
    @suggestion = Suggestion.new({
      kind: params[:kind]
      })
      set_users
  end

  def edit
  end

end
