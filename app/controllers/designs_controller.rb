class DesignsController < ApplicationController
  def new
  end

  def show
    @text = params["text"]
    @image_path = generated_image_path(@text)
  end
end
