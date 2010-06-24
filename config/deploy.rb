set :application, "objectbox"

set :repository,  "git://github.com/perenecabuto/objectbox.git"
set :scm, :git
set :user, "perenecabuto"  # The server's user for deploys
set :branch, "master"

set :deploy_via, :remote_cache

set :stage, :production
set :user, :deployer
set :use_sudo, false
set :deploy_to, "/opt/apps/objectbox"
set :app_server, :passenger
set :domain, "lukazupareli.net"

ssh_options[:forward_agent] = true

role :web, domain                   # Your HTTP server, Apache/etc
role :app, domain                   # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

namespace :deploy do
  task :start, :roles => :app, :depends => "gems:install" do
    run "cd #{current_release}; RAILS_ENV=production rake db:migrate"
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
  end

  desc "Restart Application"
  task :restart, :roles => :app, :depends => "gems:install" do
    run "cd #{current_release}; RAILS_ENV=production rake db:migrate"
    run "touch #{current_release}/tmp/restart.txt"
    run "cp #{current_release}/db/development.sqlite3 #{current_release}/db/production.sqlite3"
  end
end

namespace :gems do
  desc "Install gems"
  task :install, :roles => :app do
    run "cd #{current_path} && sudo rake RAILS_ENV=production gems:install"
  end
end
