class ImagesController < ApplicationController
  before_action :cache_response

  DESIGNS = {
    supreme: Designs::Supreme
  }

  def show
    designer = DESIGNS.fetch(params["design"].to_sym, nil)
    return head 404 unless designer

    text = params.fetch("text", "Supermeme")
    size = params.fetch("size", 100)

    generator = designer.generator
    image = generator.call(CGI::unescape(text), size: size.to_i)

    send_data image.to_blob, type: image.mime_type, disposition: 'inline'
  end

  def product_variant
    designer = DESIGNS.fetch(params["design"].to_sym, nil)
    return head 404 unless designer

    variant_id = params.fetch("variant_id")
    text = params.fetch("text", "Supermeme")

    variant = Variant.find(variant_id)
    design = designer.call(CGI::unescape(text), variant)

    send_data design.to_blob, type: design.mime_type, disposition: 'inline'
  end

  def mockup
    designer = DESIGNS.fetch(params["design"].to_sym, nil)
    return head 404 unless designer

    width = params.fetch("width", 1200)

    variant_id = params.fetch("variant_id")
    variant = Variant.find(variant_id)
    mockup_generator = Mockups::TShirt.new(color: variant.color)

    text = params.fetch("text", "Supermeme")
    design = designer.call(CGI::unescape(text), variant)
    mockup = mockup_generator.call(design, max_width: width)

    send_data mockup.to_blob, type: mockup.mime_type, disposition: 'inline'
  end

  private

  def cache_response
    fresh_when(last_modified: LAST_DEPLOY, public: true)
  end
end
