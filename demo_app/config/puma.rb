application_path = "#{File.expand_path("../..", __FILE__)}"
directory application_path
environment 'production'
daemonize true

pidfile "#{application_path}/tmp/pids/puma.pid"
state_path "#{application_path}/tmp/pids/puma.state"
stdout_redirect "#{application_path}/log/puma.stdout.log", "#{application_path}/log/puma.stderr.log"
bind "unix://#{application_path}/tmp/sockets/puma.socket"


