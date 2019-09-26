# * */4 * * * /home/vagrant/genomico/backup_cron.sh


cd "/opt/genomico"
/home/joao/.rbenv/shims/rails backup:do RAILS_ENV=production
