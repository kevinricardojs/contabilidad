threads 4,16
workers 2
preload_app!
rackup		DefaultRackup
port 		ENV['PORT']  || 3000
environment ENV['RACK_ENV']  || 'development'
on_worker_boot do
  ActiveRecord::Base.establish_connection
end