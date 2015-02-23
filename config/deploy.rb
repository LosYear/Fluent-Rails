# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'losyar-home'
set :repo_url, 'https://github.com/LosYear/Fluent-Rails.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Directory for deploying
deploy_path = "/home/www/losyar.ru/home"
set :deploy_to, deploy_path

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do

begin
  desc 'Application setup'
  task :setup_i do
    on roles(:all) do
      execute "mkdir #{shared_path}/config/"
      execute "mkdir #{deploy_path}/run/"
      execute "mkdir #{deploy_path}/log/"
      execute "mkdir #{deploy_path}/socket/"
      execute "mkdir #{shared_path}/system/"

      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:create"
        end
      end
    end
  end
end

  desc 'Creating symlinks'
  task :smlnk do
    execute "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    execute "ln -s #{shared_path}/system #{release_path}/public/system"
  end


  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  #after :publishing, :smlnk
  after :publishing, :restart

  #after :finishing, 'deploy:cleanup'
  #after :finishing, 'deploy:restart'

 # after :updating, 'deploy:smlnk'

 # before :setup, :setup_i


end

namespace :unicorn do
  unicorn_pid = "/home/www/losyar.ru/home/run/unicorn.pid"

  def run_unicorn
     execute :run, "unicorn_rails -c #{release_path}/config/unicorn.rb -D -E #{fetch(:stage)}"
  end

  desc 'Start Unicorn'
  task :start do
    on roles(:all) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, "exec unicorn -c #{release_path}/config/unicorn.rb -D -E #{fetch(:stage)}"
        end
      end
    end
  end

  desc 'Stop unicorn'
  task :stop do
    on roles(:app) do
      if test "[ -f #{unicorn_pid} ]"
        execute :kill, "-QUIT `cat #{unicorn_pid}`"
      end
    end
  end

  desc 'Force stop unicorn (kill -9)'
  task :force_stop do
    on roles(:app) do
      if test "[ -f #{unicorn_pid} ]"
        execute :kill, "-9 `cat #{unicorn_pid}`"
        execute :rm, unicorn_pid
      end
    end
  end

  desc 'Restart unicorn'
  task :restart do
    on roles(:app) do
      if test "[ -f #{unicorn_pid} ]"
        execute :kill, "-USR2 `cat #{unicorn_pid}`"
      else
        run_unicorn
      end
    end
  end
end

