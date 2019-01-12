FactoryBot.define do
  factory :product do
    title { "Unisex T-Shirt" }
    description { Faker::Lorem.sentence }
  end

  factory :printfile do
    width { 1200 }
    height { 1600 }
    dpi { 150 }
  end

  factory :variant do
    product
    color { Faker::Color.color_name.capitalize }
    size { %w[XS S M L XL 2XL 3XL 4XL].sample }
    printfile
  end
end
