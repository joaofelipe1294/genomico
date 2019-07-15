class BackupsController < ApplicationController
  def index
    @backups = Backup.all.order generated_at: :asc
  end

  def download
    backup = Backup.find params[:id]
    # temp_file = Tempfile.new(backup.dump_path)
    # p backup
    # p temp_file
    send_file(
      backup.dump_path,
      filename: 'backup.zip'
    )
  end

end
