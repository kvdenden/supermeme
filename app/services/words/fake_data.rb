# frozen_string_literal: true

module Words
  class FakeData
    GENERATORS = {
      hipster: -> { Faker::Hipster.word.capitalize },
      # ancient: -> { %i[god hero titan].sample.then { |type| Faker::Ancient.method(type).call } },
      # artist: -> { Faker::Artist.name },
      buzzword: -> { Faker::Company.buzzword.capitalize },
      cannabis: -> { Faker::Cannabis.buzzword.capitalize },
      cannabis_strain: -> { Faker::Cannabis.strain },
      coffee: -> { Faker::Coffee.blend_name },
      # color: -> { Faker::Color.color_name.capitalize },
      dessert: -> { %i[variety topping flavor].sample.then { |type| Faker::Dessert.method(type).call } },
      esport: -> { Faker::Esport.game },
      food: -> { Faker::Food.dish },
      # fruit: -> { Faker::Food.fruits },
      # vegetable: -> { Faker::Food.vegetables },
      football_team: -> { Faker::Football.team },
      hacker: -> { Faker::Hacker.adjective.capitalize },
      # kpop: -> { %i[i_groups ii_groups iii_groups girl_groups boy_bands solo].sample.then { |type| Faker::Kpop.method(type).call } },
      city: -> { Faker::Nation.capital_city },
      # nato_alphabet: -> { Faker::NatoPhoneticAlphabet.code_word },
      # programming_language: -> { Faker::ProgrammingLanguage.name },
      # chemical_element: -> { Faker::Science.element },
      # scientist: -> { Faker::Science.scientist },
      # space: -> { %i[planet moon galaxy nebula constellation star nasa_space_craft company meteorite launch_vehicule].sample.then { |type| Faker::Space.method(type).call } },
      # vehicle: -> { Faker::Vehicle.make_and_model },
      # book: -> { Faker::Book.title },
      # cat: -> { Faker::Cat.breed },
      # dog: -> { Faker::Dog.breed },
      # dog_meme: -> { Faker::Dog.meme_phrase.capitalize },
      pokemon: -> { Faker::Pokemon.name },
      # wow: -> { Faker::WorldOfWarcraft.hero },
      # zelda: -> { %i[game character item].sample.then { |type| Faker::Zelda.method(type).call } },
      dragonball: -> { Faker::DragonBall.character },
      # onepiece: -> { %i[character sea island location].sample.then { |type| Faker::OnePiece.method(type).call } },
      harry_potter: -> { %i[character house].sample.then { |type| Faker::HarryPotter.method(type).call } },
      # star_wars: -> { %i[character planet droid vehicle].sample.then { |type| Faker::StarWars.method(type).call } },
      band: -> { Faker::Music.band },
      # aqua_teen_hunger_force: -> { Faker::AquaTeenHungerForce.character },
      # bojack_horseman: -> { Faker::BojackHorseman.character },
      # game_of_thrones: -> { Faker::GameOfThrones.character },
      rick_and_morty: -> { %i[character location].sample.then { |type| Faker::RickAndMorty.method(type).call } }
    }.freeze

    def self.call(amount = 1, min_length: 5, max_length: 16, category: nil)
      tries = 0
      words = Set.new
      while words.count < amount && tries < amount * 10
        tries += 1
        new_word = (GENERATORS[category&.to_sym] || GENERATORS.values.sample).call
        words << new_word if new_word.length >= min_length && new_word.length <= max_length
      end

      amount <= 1 ? words.first : words.to_a
    end
  end
end
