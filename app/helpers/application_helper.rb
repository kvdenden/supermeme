module ApplicationHelper
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
