class DesignsController < ApplicationController
  def new
  end

  def show
    @text = params.fetch("text", "Supermeme")
    @image_path = generated_image_path(CGI::escape(@text), size: 144)
    @mockup_path = mockup_image_path(CGI::escape(@text))
  end
end
