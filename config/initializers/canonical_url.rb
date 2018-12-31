Rails.application.configure do
  config.canonical = {
    host: Rails.application.routes.default_url_options[:host],
    protocol: Rails.application.routes.default_url_options[:protocol] + "://",
    whitelisted_params: ["text"]
  }
end
