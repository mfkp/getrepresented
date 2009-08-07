set :environment, :staging
set :domain, 'hammond.sunlightlabs.org'

set :application, "getrep_#{environment}"
set :branch, 'master'
set :user, 'getrep'

set :scm, :git
set :repository, "git@github.com:sunlightlabs/getrepresented.git"
 
set :deploy_to, "/home/getrep/www/#{application}"
set :deploy_via, :remote_cache
 
role :app, domain
role :web, domain
 
set :runner, user
set :admin_runner, runner
 
after "deploy", "deploy:cleanup"
 
namespace :deploy do    
  desc "Restart the server"
  task :restart, :roles => [:web, :app] do
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end
  
  desc "Migrate the database"
  task :migrate, :roles => [:web, :app] do
    run "cd #{deploy_to}/current && rake db:migrate RAILS_ENV=#{environment}"
    deploy.restart
  end
  
  desc "Get shared files into position"
  task :after_update_code, :roles => [:web, :app] do
    run "ln -nfs #{shared_path}/database.yml #{release_path}/config/database.yml"
  end
  
  desc "Initial deploy"
  task :cold do
    deploy.update
    deploy.migrate
  end
end