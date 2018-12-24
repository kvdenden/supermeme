module ProductsHelper
  def html_description(product)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new)

    markdown.render(product.description).html_safe
  end
end
