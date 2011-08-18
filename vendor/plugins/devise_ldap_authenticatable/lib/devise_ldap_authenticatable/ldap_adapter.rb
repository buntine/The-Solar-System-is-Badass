require 'net/ldap'

module Devise

  # simple adapter for ldap credential checking
  # ::Devise.ldap_host
  module LdapAdapter

    def self.valid_credentials?(login, password)
      login = "#{::Devise.ldap_domain}\\#{login}"
      timeout = ::Devise.ldap_timeout
      @encryption = ::Devise.ldap_ssl ? :simple_tls : nil
      ldap = Net::LDAP.new(:encryption => @encryption)
      ldap.host = ::Devise.ldap_host
      ldap.port = ::Devise.ldap_port
      ldap.auth login, password

      # Ensure that the site will continue to work even
      # if the LDAP server is unavailable.
      begin
        Timeout::timeout(timeout) do
          ldap.bind
        end
      rescue Timeout::Error
        false
      end
    end

  end

end
