# frozen_string_literal: true

class Countries
  include Singleton

  def self.list
    instance.list
  end

  def self.states_for(country_code)
    instance.states_for(country_code)
  end

  def self.lookup(country_code)
    instance.lookup(country_code)
  end

  def initialize
    data = File.read("config/countries.json")

    country_list = JSON.parse(data)
    @countries = country_list.each_with_object({}) do |country, hash|
      country_code = country["code"].to_sym
      hash[country_code] = country
    end
  end

  def list
    @countries.transform_values { |country| country["name"] }
  end

  def states_for(country_code)
    country = country_code && @countries[country_code.upcase.to_sym]

    if country && country["states"]
      country["states"].each_with_object({}) do |state, hash|
        state_code = state["code"].to_sym
        hash[state_code] = state["name"]
      end
    else
      {}
    end
  end

  def lookup(country_code)
    country_code && @countries.dig(country_code.upcase.to_sym, "name")
  end
end
