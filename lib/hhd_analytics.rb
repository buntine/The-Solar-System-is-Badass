module HHDAnalytics

  # Returns true if analytics should be used on this website.
  def use_analytics?
    !!HHD::Config.analytics_profile
  end

  # Authenticates an analytics user and retrives the appropriate profile.
  def authenticate_for_profile
    begin
      Garb::Session.login(HHD::Config.analytics_email, HHD::Config.analytics_pwd)
      Garb::Profile.first(HHD::Config.analytics_profile)
    rescue
      nil
    end
  end

  # Represents the report of page views for each unique URL.
  class PageViews
    extend Garb::Resource

    metrics :pageviews
    dimensions :page_path
    sort :pageviews.desc
  end

  # Represents the report of traffic (total requests) per day.
  class Traffic
    extend Garb::Resource

    metrics :pageviews
    dimensions :date
  end

  # Represents the report of search terms used by accessing visitors.
  class SearchTerms
    extend Garb::Resource

    metrics :visits
    dimensions :keyword
    filters :keyword.not_eql => "(not set)"
    sort :visits.desc
  end

  # Represents the report of misc. data such as total visits, new visits,
  # bounces, etc.
  class Misc
    extend Garb::Resource

    metrics :pageviews, :visits, :timeOnSite, :newVisits, :bounces
  end

end
