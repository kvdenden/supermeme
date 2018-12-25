module DesignsHelper
  def color_options_for_select(product, variant)
    available_colors = product.variants.pluck(:color).uniq
    selected_color = variant.color
    options_for_select(available_colors, selected_color)
  end

  def size_options_for_select(product, variant)
    available_sizes = product.variants.pluck(:size).uniq
    selected_size = variant.size
    options_for_select(available_sizes, selected_size)
  end
end
