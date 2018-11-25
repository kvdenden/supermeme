class ImagesController < ApplicationController
  GENERATORS = {
    supreme: Generators::Supreme
  }

  def show
    generator = GENERATORS.fetch(params["generator"].to_sym, nil)
    return head 404 unless generator

    text = params.fetch("text", "Supermeme")
    size = params.fetch("size", 100)
    image = generator.call(CGI::unescape(text), size: size.to_i)

    respond_to do |format|
      format.png  { send_data image.to_blob, type: image.mime_type, disposition: 'inline' }
    end
  end
end
