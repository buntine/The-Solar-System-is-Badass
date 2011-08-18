# Tasks for interfacing with Nginx.
namespace :nginx do

  [:stop, :start, :restart, :reload, :status].each do |action|
    desc "#{action.to_s.capitalize} Nginx"
    task action, :roles => :web do
      run "#{sudo} /etc/init.d/nginx #{action.to_s}", :pty => true
    end
  end

  desc "Creates the Nginx Virtual Host configuration for this app"
  task :vh do
    set :site_conf_file, "#{site_domain}.conf"
    set :site_conf_path, "/usr/local/nginx/conf/apps/#{site_conf_file}"

    # Create the correct hostnames depending on the deployment environment.
    hostnames = if target_server == :production
      live_domains.map { |d| "www.#{d} #{d}" }.join(" ")
    else
      site_domain
    end

    # Create the correct no-www redirections if we are deploying live.
    no_www_redirections = if target_server == :production
      live_domains.map do |d| 
        <<-EOF
          if ($host = 'www.#{d}') {
            rewrite  ^/(.*)$  http://#{d}/$1  permanent;
          }
        EOF
      end.join("\n")
    end

    # Create the Nginx configuration (the indentation is intentional).
    vh_template = <<-EOF
server {
  listen      80;
  server_name #{hostnames};
  root        /var/www/apps/rails/#{application}/current/public;
  index       index.html index.htm;

  #{no_www_redirections}

  access_log /usr/local/nginx/logs/#{application}.access.log;
  error_log  /usr/local/nginx/logs/#{application}.error.log;

  passenger_enabled on;

  error_page  500 502 503 504  /50x.html;
  location = /50x.html {
    root html;
  }
}
    EOF

    # Write the configuration file to the server
    put vh_template, "./#{site_conf_file}", :mode => 0666
    sudo "mv -f ./#{site_conf_file} #{site_conf_path}", :pty => true
  end

end
