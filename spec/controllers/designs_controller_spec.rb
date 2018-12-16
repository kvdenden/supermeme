require 'rails_helper'

RSpec.describe DesignsController, type: :controller do
  describe "GET show" do
    let(:text) { Faker::Hipster.word.capitalize }

    it "assigns @text" do
      get :show, { params: { text: text } }

      expect(assigns(:text)).to eq(text)
    end

    it "assigns @image_path" do
      get :show, { params: { text: text } }

      expect(assigns(:image_path)).to eq("/images/supreme/x144/#{text}.png")
    end

    it "assigns @mockup_path" do
      get :show, { params: { text: text } }

      expect(assigns(:mockup_path)).to eq("/images/mockups/#{text}.jpg")
    end
  end
end
