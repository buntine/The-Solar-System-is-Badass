# Tasks for setting up resources on the remote server.
namespace :setup do

  set :production_db_conf, YAML::load(File.read(File.join(project_root, "config", "database.yml.example")))["production"]

  desc "Creates the database for production/staging usage. Must be run before migrating!"
  task :database do
    # Create database, new user, and setup correct privileges.
    if production_db_conf["database"] and production_db_conf["username"] and production_db_conf["password"]
      commands = ["CREATE DATABASE IF NOT EXISTS #{production_db_conf["database"]}",
                  "CREATE USER '#{production_db_conf["username"]}'@'localhost' IDENTIFIED BY '#{production_db_conf["password"]}'",
                  "GRANT ALL PRIVILEGES ON #{production_db_conf["database"]}.* TO '#{production_db_conf["username"]}'@'localhost'"]

      run "mysql -u $MYSQL_USER -p$MYSQL_PASS -e \"#{commands.join("; ")}\""
    else
      puts "You must provide a production username and password in the config/database.yml.example file"
    end
  end

  desc "Runs rake db:seed on the server"
  task :seed do
    run "cd #{current_release}; rake db:seed RAILS_ENV=production;"
  end

  desc "Irreversibly removes a website from the staging server (be careful!)"
  task :remove do
    sudo "rm -rf /usr/local/nginx/conf/apps/#{site_domain}.conf /var/www/apps/rails/#{application}", :pty => true
    sudo "rm -f /etc/logrotate.d/#{site_domain}", :pty => true
    nginx.reload

    commands = ["DROP DATABASE IF EXISTS #{production_db_conf['database']}",
                "DROP USER '#{production_db_conf['username']}'@'localhost'"]

    run "mysql -u $MYSQL_USER -p$MYSQL_PASS -e \"#{commands.join('; ')}\""
  end

  desc "Runs an arbitrary rake task on the server(s). Must receive 'task' variable"
  task :rake do
    task = variables[:task]

    if task
      run "cd #{current_release}; rake RAILS_ENV=production #{task}"
    else
      puts "You must provide a 'task' variable to this recipe: cap setup:rake -S task=my_task"
    end
  end

  desc "Creates the necessary logrotate config for this apps log files"
  task :logrotate do
    set :logrotate_conf_path, "/etc/logrotate.d/#{site_domain}"

    logrotate_template = <<-EOF
#{shared_path}/log/*.log {
  daily
  missingok
  rotate 14
  compress
  delaycompress
  notifempty
  copytruncate
}
    EOF

    # Write the file to the server (place and then move).
    put logrotate_template, "#{File.join(shared_path, site_domain)}", :mode => 0666
    sudo "mv -f #{File.join(shared_path, site_domain)} #{logrotate_conf_path}", :pty => true
  end

  desc "A full deploy to the staging/production server. Includes web server, database, etc"
  task :all do
    transaction do
      deploy.setup
      deploy.update
      setup.database
      deploy.migrate
      seed
      nginx.vh
      setup.logrotate
      nginx.reload
    end
  end

end
