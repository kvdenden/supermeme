class ImagesController < ApplicationController
  GENERATORS = {
    supreme: Generators::Supreme
  }

  def show
    generator = GENERATORS.fetch(params["generator"].to_sym, nil)
    return head 404 unless generator

    text = params["text"]
    image = generator.call(text)

    respond_to do |format|
      format.png  { send_data image.to_blob, type: image.mime_type, disposition: 'inline' }
    end
  end
end
