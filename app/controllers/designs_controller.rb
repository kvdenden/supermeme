class DesignsController < ApplicationController
  def new
  end

  def show
    @text = params["text"]
  end
end
