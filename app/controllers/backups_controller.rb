class BackupsController < ApplicationController
  def index
    @backups = Backup.all.order generated_at: :desc
  end

  def download
    backup = Backup.find params[:id]
    send_file(
      backup.dump_path,
      filename: 'backup.zip'
    )
  end

end
