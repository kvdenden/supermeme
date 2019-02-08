Rails.application.configure do
  config.fulfillment = {
    confirm_order: ENV["FULFILLMENT_CONFIRM_ORDER"] == "true",
    external_id_suffix: ENV["FULFILLMENT_EXTERNAL_ID_SUFFIX"]
  }
end
