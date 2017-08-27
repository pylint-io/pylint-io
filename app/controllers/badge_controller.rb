class BadgeController < ApplicationController
  def generate
    left, @rating = params[:spec].split('-')
    if @rating
      render "generate", layout: false, content_type: "image/svg+xml"
    else
      render "unknown", layout: false, content_type: "image/svg+xml"
    end
  end
end
