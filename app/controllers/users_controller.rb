class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    set_users
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @user_kinds = UserKind.all.order(name: :desc)
  end

  # GET /users/1/edit
  def edit
    @user_kinds = UserKind.all.order(name: :desc)
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if user_params[:password] != user_params[:password_confirmation]
      @user.errors[:password] = ' informada não combina.'
      @user_kinds = UserKind.all.order(name: :desc)
      return render new_user_path(@user) 
    end
    if @user.save
      flash[:success] = 'Usuário cadastrado com sucesso.'
      redirect_to home_admin_index_path
    else
      @user_kinds = UserKind.all.order(name: :desc)
      render new_user_path(@user)
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update user_params
      flash[:success] = 'Usuário editado com sucesso.'
      redirect_to home_admin_index_path
    else
      @user_kinds = UserKind.all.order(name: :desc)
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
    @user = User.find params[:id]
  end

  def change_password
    @user = User.find params[:id]
    puts 'MALAKOS '
    puts params[:password]
    puts @user.inspect
    if user_params[:password] != user_params[:password_confirmation] || user_params[:password].empty?
      flash[:warning] = 'As senhas informadas não combinam.'
      render :change_password_view
    elsif @user.update(user_params)
      flash[:success] = 'Senha alterada com sucesso.'
      redirect_to home_admin_index_path
    else
      puts @user.errors.inspect
      flash[:warning] = 'Houve um problema no servidor, tente novamente mais tarde.'
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
      params.require(:user).permit(:login, :password, :password_confirmation, :name, :user_kind_id)
    end

    def set_users
      if params[:kind].nil?
        @users = User.all.order(:name)
      else
        @users = User.where({user_kind: UserKind.find_by(name: 'admin')}) if params[:kind] == 'admin'
        @users = User.where({user_kind: UserKind.find_by(name: 'user')}) if params[:kind] == 'user'
      end
    end

end
