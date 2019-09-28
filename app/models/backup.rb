class Backup < ActiveRecord::Base
  paginates_per 10

  def self.perform_backup
    puts Rails.env
    if File.directory?("./public/backups") == false
      `mkdir public/backups`
      `mkdir public/backups/temp`
    end
    if Rails.env.production?
      puts "PRODUCTION"
      `PGPASSWORD="lab_genomico_HPP_2106" pg_dump -Fc -U deploy -h localhost genomico > ./public/backups/temp/pgdump.dump`
    else
      puts "DESENVOLVIMENTO"
      `PGPASSWORD="1234" pg_dump -Fc -U postgres -h localhost genomico_development > ./public/backups/temp/pgdump.dump`
    end
    `cp -r public/system/ ./public/backups/temp`
    date_to_save = DateTime.now
    current_date = date_to_save.to_i
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
      backup_to_remove = Backup.order(generated_at: :desc).limit(11).last
      `rm #{backup_to_remove.dump_path}`
      backup_to_remove.dump_path = ""
      backup_to_remove.status = false
      backup_to_remove.save
    end
    backup = Backup.new({
      status: true,
      dump_path: "#{Rails.root}/public/backups/genomico_backup_#{current_date}.zip",
      generated_at: date_to_save
    })
    backup.save
  end

  def self.restore(database, file_path)
    `mkdir ./public/backups/temp_restore`
    `cp #{file_path} ./public/backups/temp_restore/`
    `unzip public/backups/temp_restore/#{file_path.split("/").last} -d ./public/backups/temp_restore/`
    `cp -r ./public/backups/temp_restore/system/ ./public/`
    `PGPASSWORD="1234" pg_restore -h localhost -p 5432 -U postgres -c -d genomico_development -v ./public/backups/temp_restore/pgdump.dump`
    `rm -r ./public/backups/temp_restore`
    `sudo -u postgres psql -d genomico_development -c "REASSIGN OWNED BY deploy TO postgres;"`
    true
  end

end
