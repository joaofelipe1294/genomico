class UsersController < ApplicationController
  include InstanceVariableSetter
  before_action :set_user, only: [:show, :edit, :update, :destroy, :change_password, :change_password_view]
  before_action :admin_filter
  before_action :set_fields, only: [:new, :edit, :create, :update, :activate]

  # GET /users
  # GET /users.json
  def index
    set_users
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = I18n.t :new_user_success
      redirect_to home_admin_index_path
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update user_params
      flash[:success] = :edit_user_success
      redirect_to home_admin_index_path
    else
      render :edit
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user.update({is_active: false})
      flash[:success] = 'Usuário inativado com sucesso.'
      redirect_to home_admin_index_path
    else
      flash[:warning] = 'Não foi possível inativar este usuário.'
      set_users
      render :index
    end
  end

  #POST /activate
  def activate
    user = User.find params[:id]
    if user.update({is_active: true})
      flash[:success] = 'Usuário reativado com sucesso.'
      redirect_to home_admin_index_path
    else
      flash[:warning] = 'Não foi possível ativar o usuário, tente novamente mais tarde.'
      set_users
      render :index
    end
  end

  def change_password_view
  end

  def change_password
    if @user.update(user_params)
      flash[:success] = 'Senha alterada com sucesso.'
      redirect_to home_admin_index_path
    else
      flash[:warning] = @user.errors.full_messages.first
      render :change_password_view
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      permited_params = params.require(:user).permit(
          :login,
          :password,
          :password_confirmation,
          :name,
          :kind,
          :fields
        )
      fields = params[:user][:fields]
      permited_params[:fields] = fields.map { |field_id| Field.find field_id.to_i } if fields
      permited_params
    end

    def set_users
      user_kind_id = params[:kind]
      unless user_kind_id.present?
        users = User.all
      else
        users = User.where(kind: :admin) if user_kind_id == 'admin'
        users = User.where(kind: :user) if user_kind_id == 'user'
      end
      @users = users.order(:name)
    end

end
