# frozen_string_literal: true

module ApplicationHelper
  def canonical_url
    config = Rails.application.config.canonical

    protocol = config[:protocol] || request.protocol
    host = config[:host] || request.host_with_port
    path = request.path
    filtered_params = request.params.select { |k, v| v.present? && config[:whitelisted_params]&.include?(k) }
    query_string = "?" + filtered_params.transform_values(&:strip).to_param if filtered_params.present?
    "#{protocol}#{host}#{path}#{query_string}"
  end

  def nav_link_to(body, url)
    nav_class = "nav-link"
    nav_class += " active" if request.path == url
    link_to body, url, class: nav_class
  end

  def copyright_message
    from_year = 2018
    current_year = Date.current.year

    display_year = current_year == from_year ? "#{from_year}" : "#{from_year}-#{current_year}"
    "&copy; #{display_year} Supermeme. All Rights Reserved."
  end
end
