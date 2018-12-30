Rails.application.configure do
  config.google_analytics = {
    tracking_id: ENV["GOOGLE_ANALYTICS_TRACKING_ID"]
  }
end
