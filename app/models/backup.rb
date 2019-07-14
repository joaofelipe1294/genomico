class Backup < ActiveRecord::Base

    def self.perform_backup
      if File.directory?("./public/backups") == false
        `mkdir public/backups`
        `mkdir public/backups/temp`
      end
      `pg_dump -U postgres -F t genomico_development > ./public/backups/temp/pgdump.tar`
      `cp -r public/system/ ./public/backups/temp`
      current_date = DateTime.now.to_i
      zip_name = "genomico_backup_#{current_date}.zip"
      `cd ./public/backups/temp && zip -r ../#{zip_name} .`
      `rm -r ./public/backups/temp && mkdir ./public/backups/temp`
      backup_files = `ls ./public/backups/*.zip`
      files = backup_files.split "\n"
      if files.size > 10
        backup_dates = []
        files.each do |file|
          file_date = file.split("_").last.split(".").first
          generated_at = Time.at(file_date.to_i).to_datetime
          backup_dates.append generated_at
        end
        `rm ./public/backups/genomico_backup_#{backup_dates.min.to_i}.zip`
        Backup.order(generated_at: :asc).last.delete
      end
      Backup.create({
        status: true,
        dump_path: "./public/backups/genomico_backup_#{current_date}.zip",
        generated_at: current_date
      })
      true
    end

end
