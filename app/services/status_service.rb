class StatusService

  def call
    {
      disk_usage: {
        backups: get_backup_disk_usage,
        logs: get_logs_disk_usage
      },
      backup: last_backup_date,
      patients: Patient.all.size,
      attendances: Attendance.all.size,
      exams: Exam.all.size
    }

  end

  private

    def get_backup_disk_usage
      cmd_result = `ls -lh $(pwd)/public/backups/`
      results = cmd_result.split "\n"
      results.first
    end

    def get_logs_disk_usage
      cmd_result = `ls -lh $(pwd)/log`
      results = cmd_result.split "\n"
      results.first
    end

    def last_backup_date
      backup = Backup.all.order(created_at: :desc).first
      if backup
        backup.generated_at.utc.strftime('%H:%M  -  %d/%m/%Y')
      else
        I18n.t :without_backups_message
      end
    end

end
