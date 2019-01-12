class Fulfiller < ApplicationRecord
  def self.printful
    find_by(name: 'Printful')
  end
end
