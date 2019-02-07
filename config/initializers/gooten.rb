Rails.application.configure do
  config.gooten = {
    recipe_id: ENV.fetch("GOOTEN_RECIPE_ID"),
    partner_billing_key: ENV.fetch("GOOTEN_PARTNER_BILLING_KEY"),
    external_id_suffix: ENV["GOOTEN_EXTERNAL_ID_SUFFIX"]
  }
end
