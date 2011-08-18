class Admin < ActiveRecord::Base

  devise :database_authenticatable, :ldap_authenticatable, :recoverable, :rememberable

  validates_presence_of :full_name

  validates_length_of :password, :within => 8..18, :unless => lambda { |u| u.ldap == true }

  attr_accessible :full_name, :email, :password, :password_confirmation, :remember_me, :ldap

end
