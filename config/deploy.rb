# RVM bootstrap
$:.unshift(File.expand_path("~/.rvm/lib"))
require 'rvm/capistrano'
set :rvm_ruby_string, '1.9.2-p290'
set :rvm_type, :user

require 'bundler/capistrano'

set :application, "isfit.org"
set :repository,  "git@github.com:isfit/isfit.org"

set :scm, :git

role :web, "nova.isfit.org"                           # Your HTTP server, Apache/etc
role :app, "nova.isfit.org"                           # This may be the same as your `Web` server
role :db,  "nova.isfit.org", :primary => true         # This is where Rails migrations will run

set :branch, "3.1-test"
set :user, "passenger"
set :use_sudo, false
set :deploy_to, "/srv/www/www.isfit.org"
set :deploy_via, :remote_cache
default_run_options[:pty] = true  # Must be set for the password prompt from git to work
ssh_options[:forward_agent] = true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :symlink_shared, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -s /srv/shared/article_images #{release_path}/public/assets/article_images"
    run "ln -s /srv/shared/downloads #{release_path}/public/assets/downloads"
    run "ln -s /srv/shared/events #{release_path}/public/assets/events"
    run "ln -s /srv/shared/article #{release_path}/public/assets/article"
    run "ln -s /srv/shared/page_images #{release_path}/public/assets/page_images"
    run "ln -s /srv/shared/pages #{release_path}/public/assets/pages"
    run "ln -s /srv/shared/press_release #{release_path}/public/assets/press_release"
    run "ln -s /srv/shared/programme_images #{release_path}/public/assets/programme_images"
    run "ln -s /srv/shared/slide #{release_path}/public/assets/slide"
    run "ln -s /srv/shared/workshop_images #{release_path}/public/assets/workshop_images"
    run "ln -s /srv/shared/workshops #{release_path}/public/assets/workshops"
  end
end
after 'deploy:update_code', 'deploy:symlink_shared'
