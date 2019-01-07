# frozen_string_literal: true

class CountriesController < ApplicationController
  def states
    country_code = params[:country_code]
    states = Countries.states_for(country_code) || []

    respond_to do |format|
      format.json { render json: states }
    end
  end
end
