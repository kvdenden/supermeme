module ApplicationHelper
  def copyright_message
    from_year = 2018
    current_year = Date.current.year

    display_year = current_year == from_year ? "#{from_year}" : "#{from_year}-#{current_year}"
    "&copy; #{display_year} Supermeme. All Rights Reserved."
  end
end
