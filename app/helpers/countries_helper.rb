module CountriesHelper
  def country_options_for_select(selected: nil)
    options_for_select(Countries.list.invert, selected&.upcase)
  end

  def state_options_for_select(country_code, selected: nil)
    options_for_select(Countries.states_for(country_code).invert, selected&.upcase)
  end
end
