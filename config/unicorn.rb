#config/unicorn.conf

# See http://unicorn.bogomips.org/Unicorn/Configurator.html for complete
# See also http://unicorn.bogomips.org/examples/unicorn.conf.rb for
rails_env = 'production'
worker_processes 1
working_directory '/home/rayko/www/rss-reader'
port = 14000
pid 'tmp/pids/unicorn.pid'
preload_app  true
