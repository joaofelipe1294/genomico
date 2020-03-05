class FishApiController < ApplicationController

  def users
    users = User.where(is_active: true).order(:login)
    render json: users, status: :ok, only: [:id, :login]
  end

end
