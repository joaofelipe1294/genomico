#adicionar permissao de execucao
# chmod +x backup_cron.sh
#adicionar ao cron
# * */2 * * * /opt/genomico/backup_cron.sh


cd "/opt/genomico"
/home/joao/.rbenv/shims/rails backup:do RAILS_ENV=production
