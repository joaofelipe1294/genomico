class BackupsController < ApplicationController
  def index
    @backups = Backup.all.where(status: true).order generated_at: :asc
  end

  def download
    backup = Backup.find params[:id]
    send_file(
      backup.dump_path,
      filename: 'backup.zip'
    )
  end

end
