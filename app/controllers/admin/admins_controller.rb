class Admin::AdminsController < AdminController

  active_scaffold :admin do |config|
    config.list.label = "Administrators"
    config.create.label = "Create administrator"
    config.columns = [:email, :full_name, :password, :password_confirmation, :updated_at]
    list.columns.exclude :password, :password_confirmation
    show.columns.exclude :password, :password_confirmation

    config.columns[:password].form_ui = :password
    config.columns[:password_confirmation].form_ui = :password

    config.columns[:updated_at].options = {:format => "%d/%m/%Y %I:%M%p"}
  end 

 private

  # The LDAP integration will create the users after they've loggin-in,
  # but we don't want to show those.
  def conditions_for_collection
    {:ldap => false}
  end

end
