# frozen_string_literal: true

class WordsController < ApplicationController
  def fake
    count = params.fetch('count', 20).to_i
    category = params['category']

    render json: Words::FakeData.call(count, category: category)
  end

  def related
    word = params.fetch("word", "")
    count = params.fetch('count', 20).to_i

    render json: Words::Related.call(word, count)
  end
end
