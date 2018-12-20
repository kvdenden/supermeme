PrintfulAPI.api_key = Rails.application.credentials.printful_api_key

Rails.application.configure do
  config.printful = {
    confirm_order: !!ENV["PRINTFUL_CONFIRM_ORDER"]
  }
end
