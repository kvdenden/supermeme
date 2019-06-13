# frozen_string_literal: true

class ImagesController < ApplicationController
  include NormalizeText

  before_action :cache_response, :validate_text
  after_action :force_gc

  DESIGNS = {
    supreme: Designs::Supreme
  }.freeze

  def show
    designer = DESIGNS.fetch(params['design'].to_sym, nil)
    return head 404 unless designer

    text = normalized_text
    size = params.fetch('size', 100)

    generator = designer.generator
    image = generator.call(text, size: size.to_i)

    send_data image.to_blob, type: image.mime_type, disposition: 'inline'
  ensure
    image&.destroy!
  end

  def printfile
    designer = DESIGNS.fetch(params['design'].to_sym, nil)
    return head 404 unless designer

    text = normalized_text
    printfile_id = params.fetch('printfile_id')

    printfile = Printfile.find(printfile_id)
    design = designer.call(text, printfile)

    send_data design.to_blob, type: design.mime_type, disposition: 'inline'
  ensure
    design&.destroy!
  end

  def mockup
    designer = DESIGNS.fetch(params['design'].to_sym, nil)
    return head 404 unless designer

    text = normalized_text
    width = params.fetch('width', 1200)
    color = params.fetch('color', 'black').capitalize

    product = Product.first
    variant = product.variants.where(color: color).first || product.variants.first
    printfile = variant.fulfiller_variants.first.printfile
    mockup_generator = Mockups::TShirt.new(color: variant.color)

    design = designer.call(text, printfile)
    mockup = mockup_generator.call(design, max_width: width)

    send_data mockup.to_blob, type: mockup.mime_type, disposition: 'inline'
  ensure
    design&.destroy!
    mockup&.destroy!
  end

  def adjust
    designer = DESIGNS.fetch(params['design'].to_sym, nil)
    return head 404 unless designer

    text = normalized_text

    generator = designer.generator

    render json: { moveDown: generator.move_down?(text) }
  end

  private

  def cache_response
    fresh_when(last_modified: LAST_DEPLOY, public: true)
  end

  def validate_text
    render head 404 if normalized_text.length > 24
  end

  def force_gc
    if ObjectSpace.each_object(Magick::Image).count > 100
      logger.debug 'Forcing Garbage Collection'
      ObjectSpace.garbage_collect
    end
  end
end
