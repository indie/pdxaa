require "bundler/capistrano"

server "23.239.20.69", :web, :app, :db, primary: true 
# backup site # server "50.116.55.80", :web, :app, :db, primary: true

set :application, "pdxaa"
set :user, "hub"

# 50 linode config
 default_environment['PATH'] = '/home/hub/.rbenv/versions/1.9.3-p551/bin:$PATH'
 default_environment['GEM_PATH']= '/home/hub/.gem/ruby/1.9.1'


# backup site # set :deploy_to, "/home/hub/public/findmeetings.org/public/pdxaa/#{application}"
set :deploy_to, "/home/hub/public/pdxaa.org/public/meetings/#{application}"

set :deploy_via, :remote_cache
set :use_sudo, false

set :default_environment, { 'PATH' => "/home/hub/.rbenv/versions/1.9.3p551/bin:$PATH" }
default_environment['GEM_PATH']= '/home/hub/.gem/ruby/1.9.1'
# default_environment['PATH'] = '/home/hub/.rbenv/versions/1.9.3-p194/bin:$PATH'
# set :default_environment, {
#      'PATH' => "home/hub/.rbenv/versions/1.9.3-p194/bin:$PATH"
#    }

set :scm, "git"
set :repository, "git@github.com:indie/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  task :start do; end
  task :stop do; end
  task :restart, roles: :app, except: {no_release: true} do
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/apache.conf /etc/apache2/sites-available/#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end

  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end