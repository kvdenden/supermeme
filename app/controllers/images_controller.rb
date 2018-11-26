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

    send_data image.to_blob, type: image.mime_type, disposition: 'inline'
  end

  def mockup
    designer = Designs::Supreme

    variant = Variant.first # TODO: make this better :)
    mockup_generator = Mockups::TShirt

    text = params.fetch("text", "Supermeme")
    design = designer.call(CGI::unescape(text), variant)
    mockup = mockup_generator.call(design)

    send_data mockup.to_blob, type: mockup.mime_type, disposition: 'inline'
  end
end
