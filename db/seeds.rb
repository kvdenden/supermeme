# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

DatabaseCleaner.clean_with(:truncation) unless Rails.env.production?

def parse_fulfiller_data(data)
  fulfiller_attributes = %w(name).map { |a| [a.to_sym, data[a]] }.to_h
  Fulfiller.new(fulfiller_attributes)
end

def parse_printfile_data(data)
  printfile_attributes = %w(width height dpi).map { |a| [a.to_sym, data[a]] }.to_h
  Printfile.new(printfile_attributes)
end

def parse_product_data(data)
  product_attributes = %w(title description).map { |a| [a.to_sym, data[a]] }.to_h
  Product.new(product_attributes)
end

def parse_fulfiller_product_data(data, fulfillers)
  fulfiller_product_attributes = %w(external_id).map { |a| [a.to_sym, data[a]] }.to_h
  fulfiller_product_attributes[:fulfiller] = fulfillers.fetch(data['fulfiller'])
  FulfillerProduct.new(fulfiller_product_attributes)
end

def parse_variant_data(data, printfiles)
  variant_attributes = %w(external_id color size price).map { |a| [a.to_sym, data[a]] }.to_h
  variant_attributes[:printfile] = printfiles.fetch(data['printfile'])
  Variant.new(variant_attributes)
end

seeds = YAML.load_file('./db/seed_data.yml')

fulfillers = {}
seeds['fulfillers'].each do |key, fulfiller_data|
  fulfiller = parse_fulfiller_data(fulfiller_data)
  fulfiller.save!
  fulfillers[key] = fulfiller
end

printfiles = {}
seeds['printfiles'].each do |key, printfile_data|
  printfile = parse_printfile_data(printfile_data)
  printfile.save!
  printfiles[key] = printfile
end

seeds['products'].each do |key, product_data|
  product = parse_product_data(product_data)
  product.save!

  product_data['fulfiller_products'].each do |fulfiller_product_data|
    fulfiller_product = parse_fulfiller_product_data(fulfiller_product_data, fulfillers)
    fulfiller_product.product = product
    fulfiller_product.save!
  end

  product_data['variants'].each do |variant_data|
    variant = parse_variant_data(variant_data, printfiles)
    variant.product = product
    variant.save!
  end
end
