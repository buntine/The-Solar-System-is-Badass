class AdminController < ApplicationController

  layout "admin"

  before_filter :authenticate_admin_unless_local
  helper_method :use_analytics?

  include HHDAnalytics

  def index
    if use_analytics?
      profile = authenticate_for_profile
      dates = {:start_date => (Date.today - 30), :end_date => Date.today}

      if profile
        # Generate each report from our analytics account.
        @page_views = PageViews.results(profile, dates.merge(:limit => 8))
        @traffic = Traffic.results(profile, dates)
        @terms = SearchTerms.results(profile, dates.merge(:limit => 8))
        @misc_data = Misc.results(profile, dates).first

        render :template => "/admin/analytics_dashboard"
      end
    end
  end

  ActiveScaffold.set_defaults do |config| 
    config.ignore_columns.add [:created_at, :updated_at]
  end
  
  class << self
    # This method should return an array describing the navigation system for this CMS.
    # Please read ./doc/01-cms_navigation.txt for a reference.
    def cms_nav
      [Admin::AdminsController]
    end

    # Overload in subclass (define 'self.nav_title') to give a custom CMS navigation title.
    # We use alias_method so the original definition is always available.
    def nav_title
      self.to_s.sub("Admin::", "").sub(/Controller$/, "").titleize
    end
    alias_method :orig_nav_title, :nav_title
  end

  def authenticate_admin_unless_local
    authenticate_admin! unless request.host == "localhost"
  end
end
