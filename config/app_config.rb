# This is where I place all application-wide "constants" and configuration.
# It's much nicer than using global variables. The pattern is described at the
# URL below:
#
# Source: http://toolmantim.com/thoughts/consolidating_your_apps_constants

require "active_support"

module HHD
  module Config
    mattr_accessor :admin_email, :client_name, :analytics_email, :analytics_pwd
    mattr_accessor :analytics_profile

    @@admin_email = "client@client.com.au"
    @@client_name = "Client/Project name"

    # You MUST provide a profile ID in order for the analytics dashboard 
    # to display on the CMS landing page. They look like this: UA-12345678-1
    @@analytics_email = "hhdanalytics@gmail.com"
    @@analytics_pwd = "n00dl3w0rld"
    @@analytics_profile = nil
  end
end
