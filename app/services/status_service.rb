class StatusService

  def call
    {
      disk_usage: {
        backups: get_disk_usage("public/backups/"),
        logs: get_disk_usage("log/")
      },
      backup: last_backup_date,
      patients: Patient.all.size,
      attendances: Attendance.all.size,
      exams: Exam.all.size
    }

  end

  private

    def last_backup_date
      backup = Backup.all.order(created_at: :desc).first
      if backup
        backup.generated_at.utc.strftime('%H:%M  -  %d/%m/%Y')
      else
        I18n.t :without_backups_message
      end
    end

    def get_disk_usage path
      if Rails.env == "production"
        cmd_result = `ls -lh /opt/genomivo/#{path}`
      else
        cmd_result = `ls -lh $(pwd)/#{path}`
      end
      results = cmd_result.split "\n"
      results.first
    end

end
