namespace :backup do
  desc "Executes backup and restore logic"
  task do: :environment do
    Backup.perform_backup
  end

  task restore: :environment do
    puts "Starting restore ..."
    Backup.restore(ARGV[2], ARGV[1])
  end

end
