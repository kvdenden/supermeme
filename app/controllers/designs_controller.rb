class DesignsController < ApplicationController
  def new
  end

  def show
    @text = params["text"]
    @image_path = Generators::Supreme.call(@text)
  end
end
