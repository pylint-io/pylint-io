class BadgeController < ApplicationController
  def generate
    left, @rating = params[:spec].split('-')
    if @rating
      render "badge", layout: false, content_type: "image/svg+xml"
    else
      render "unknown", layout: false, content_type: "image/svg+xml"
    end
  end
  
  # Retrieve a rating and render a badge
  def github
    # set defaults if params not specified
    if not params[:branch]
      params[:branch] = 'master'
    end
    if not params[:module]
      params[:module] = params[:repository]
    end
    
    conditions = { \
      :service => :github, \
      :organization => params[:organization], \
      :repository => params[:repository], \
      :branch => params[:branch], \
      :module => params[:module], \
    }
    @rating = Rating.where(conditions).order(:created_at).first

    respond_to do |format|
      format.svg do
        if @rating
          render "badge", layout: false, content_type: "image/svg+xml"
        else
          render "unknown", layout: false, content_type: "image/svg+xml"
        end
      end
      format.json do
        render "rating"
      end
    end

  end
end
