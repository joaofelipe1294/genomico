class ReleasesController < ApplicationController
  before_action :set_release, only: [:destroy]
  before_action :admin_filter, except: [:update]

  # GET /releases
  # GET /releases.json
  def index
    @releases = Release.all.order(created_at: :asc)
  end

  # GET /releases/new
  def new
    @release = Release.new
  end

  # POST /releases
  # POST /releases.json
  def create
    @release = Release.new(release_params)
    if @release.save
      flash[:success] = I18n.t :new_release_success
      redirect_to releases_path
    else
      render :new
    end
  end

  # DELETE /releases/1
  # DELETE /releases/1.json
  def destroy
    @release.release_checks.each { |release_check| release_check.update(has_confirmed: true) }
    redirect_to releases_path
  end

  def update
    release_check = ReleaseCheck.find params[:release_check]
    if release_check.update has_confirmed: :true
      flash[:success] = I18n.t :success_check_release
    else
      flash[:error] = release_check.errors.full_messages.first
    end
    redirect_to home_path
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_release
      @release = Release.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def release_params
      params.require(:release).permit(:name, :tag, :message, :is_active)
    end
end
