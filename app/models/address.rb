# frozen_string_literal: true

class Address < ApplicationRecord
  has_one :purchase_order

  validates :street1, presence: true
  validates :city, presence: true
  validate :validate_country
  validate :validate_state_for_country

  def country
    Countries.lookup(country_code)
  end

  private

  def validate_country
    if country.nil?
      errors.add(:country_code, "is invalid")
    end
  end

  def validate_state_for_country
    valid_state_codes = Countries.states_for(country_code).keys
    if valid_state_codes.present? && !valid_state_codes.any?(state_code&.upcase&.to_sym)
      errors.add(:state_code, "is invalid")
    end
  end
end
