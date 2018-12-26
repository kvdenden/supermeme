PrintfulAPI.api_key = ENV.fetch("PRINTFUL_API_KEY")

Rails.application.configure do
  config.printful = {
    confirm_order: !!ENV["PRINTFUL_CONFIRM_ORDER"]
  }
end
