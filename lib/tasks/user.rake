namespace :user do
  desc "Generate a report with user last lgin info"
  task login_info: :environment do
    puts "================== ATIVOS =================="
    User.where.not(last_login_at: nil).order(login: :asc).each do |user|
      last_login_at = user.last_login_at.strftime("%d/%m/%Y  %H:%M")
      puts "#{user.name}   =>   #{last_login_at}"
    end
    puts "============================================"
    puts "\n\n"
    puts "================== INATIVOS ================"
    User.where(last_login_at: nil).order(login: :asc).each do |user|
      puts "#{user.name}"
    end
    puts "============================================"
  end

end
