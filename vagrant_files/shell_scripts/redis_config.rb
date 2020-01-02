current_crontab = `crontab -l`.strip
if current_crontab.empty?
  puts "Adicioanar config no cron !!!"
  puts "Adicione crontab com a seguinte linha"
  puts "crontab -e"
  puts "@reboot /usr/local/bin/redis-server redis/redis-5.0.5/redis.conf"
end
