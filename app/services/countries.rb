
class Countries
  include Singleton

  def self.all
    instance.countries
  end

  def self.states(country_code)
    instance.states(country_code)
  end

  def initialize
    data = File.read("config/countries.json")

    country_list = JSON.parse(data)
    @countries = country_list.each_with_object({}) do |country, hash|
      country_code = country["code"].to_sym
      hash[country_code] = country
    end
  end

  def countries
    @countries.transform_values { |country| country["name"] }
  end

  def states(country_code)
    country = @countries[country_code.upcase.to_sym]

    if country && country["states"]
      country["states"].each_with_object({}) do |state, hash|
        state_code = state["code"].to_sym
        hash[state_code] = state["name"]
      end
    end
  end
end
