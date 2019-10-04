namespace :backup do
  desc "Executes backup"
  task do: :environment do
    Backup.perform_backup
  end

  desc "Executes restore receive a zip file with the backup"
  task restore: :environment do
    puts "Starting restore ..."
    Backup.restore(ARGV[2], ARGV[1])
  end

end
