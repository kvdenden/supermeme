class DesignsController < ApplicationController
  def new
  end

  def show
    @text = params["text"]
    @image_path = generated_image_path(CGI::escape(@text), size: 72)
  end
end
