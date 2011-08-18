module AdminHelper

  # Returns an array of plotted points for the Flot graph on the CMS landing page.
  def generate_flot_data(traffic)
    traffic.enum_with_index.map do |t, i|
      [i, t.pageviews.to_i]
    end
  end

  # Generates the CMS navigation markup. The navigation is generated
  # by parsing the array returned by 'AdminController.cms_nav'. Please
  # Please read ./doc/01-cms_navigation.txt for a reference.
  def cms_navigation
    nav = AdminController.cms_nav.map do |section|
      # First element is the title, second element is array of children.
      if section.is_a?(Array)
        render :partial => "/admin/nav_section",
               :locals => {:title => section[0], :children => section[1]}
      # Class should contain a partial override.
      elsif section.is_a?(Class)
        render_partial_for_controller(section)
      else
        raise RuntimeError, "Unexpected CMS nav value: #{section}"
      end
    end

    nav.compact.join("\n")
  end

  # Renders a navigation partial for the given admin controller.
  def render_partial_for_controller(section)
    section_path = cms_nav_url(section)
    custom_view = File.join(RAILS_ROOT, "app", "views", section_path, "_nav.html.erb")

    # Render the custom view if possible, otherwise just the detault.
    partial = File.join((File.exists?(custom_view) ? section_path : "admin"), "nav")

    render :partial => partial, :locals => {:resource => section}
  end

  # Generates a URL for a CMS section given the controller name:
  #   Admin::ProductCategoriesController -> "/admin/product_categories"
  def cms_nav_url(resource)
    "/#{resource.to_s.sub("::", "/").sub(/Controller$/, "").underscore}/"
  end

end
