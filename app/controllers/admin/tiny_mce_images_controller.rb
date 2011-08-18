class Admin::TinyMceImagesController < AdminController

  active_scaffold :tiny_mce_image do |config|
    config.list.label = "Editor Images"
    config.actions.exclude :create

    config.columns = [:alt, :file, :created_at]

    config.columns[:created_at].options = {:format => "%d/%m/%Y %I:%M%p"}
  end 

end
