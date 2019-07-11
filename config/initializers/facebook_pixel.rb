Rails.application.configure do
    config.facebook_pixel = {
      tracking_id: ENV["FACEBOOK_PIXEL_TRACKING_ID"]
    }
  end