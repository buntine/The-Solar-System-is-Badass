class TinyMceUploadGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      m.directory "app"
        m.directory "app/controllers"
          m.file "tiny_mce_images_controller.rb", "app/controllers/tiny_mce_images_controller.rb"
        m.directory "app/models"
          m.file "tiny_mce_image.rb", "app/models/tiny_mce_image.rb"
        m.directory "app/views"
        m.directory "app/views/tiny_mce_images"
          m.file "create.html.erb", "app/views/tiny_mce_images/create.html.erb"
          m.file "new.html.erb", "app/views/tiny_mce_images/new.html.erb"
      m.directory "db"
        m.directory "db/migrate"
          m.file "20101012080655_create_tiny_mce_images.rb", "db/migrate/20101012080655_create_tiny_mce_images.rb"

      m.directory "public"
        m.directory "public/javascripts"
          m.directory "public/javascripts/tiny_mce"
            m.directory "public/javascripts/tiny_mce/plugins"
              m.directory "public/javascripts/tiny_mce/plugins/upload"
                m.file "javascript/editor_plugin_src.js",  "public/javascripts/tiny_mce/plugins/upload/editor_plugin_src.js"
                m.directory "public/javascripts/tiny_mce/plugins/upload/img"
                  m.file "javascript/img/upload.png",        "public/javascripts/tiny_mce/plugins/upload/img/upload.png"
                m.directory "public/javascripts/tiny_mce/plugins/upload/js"
                  m.file "javascript/js/dialog.js",          "public/javascripts/tiny_mce/plugins/upload/js/dialog.js"
                m.directory "public/javascripts/tiny_mce/plugins/upload/langs"
                  m.file "javascript/langs/en.js",           "public/javascripts/tiny_mce/plugins/upload/langs/en.js"
                  m.file "javascript/langs/en_dlg.js",       "public/javascripts/tiny_mce/plugins/upload/langs/en_dlg.js"
    end
  end
end
