class Fulfiller < ApplicationRecord
  def self.printful
    find_by(name: 'Printful')
  end

  def self.gooten
    find_by(name: 'Gooten')
  end
end
