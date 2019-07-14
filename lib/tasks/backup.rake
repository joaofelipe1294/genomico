namespace :backup do
  desc "Executes backup logic"
  task do: :environment do
    puts "Updating news Articles…"
    Backup.perform_backup
    puts "#{Time.now} — Success!"

    # Rake::Task['universe:world:shout'].invoke
  end

end
