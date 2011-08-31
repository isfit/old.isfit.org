set :application, "isfit.org"
set :repository,  "git@github.com:isfit/isfit.org"

set :scm, :git

role :web, "nova.isfit.org"                          # Your HTTP server, Apache/etc
role :app, "nova.isfit.org"                          # This may be the same as your `Web` server
role :db,  "nova.isfit.org", :primary => true # This is where Rails migrations will run

set :branch, "3.1-test"
set :user, "passenger"
set :use_sudo, false
set :deploy_to, "/srv/www/www.isfit.org"
set :deploy_via, :remote_cache
default_run_options[:pty] = true  # Must be set for the password prompt from git to work

 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end
