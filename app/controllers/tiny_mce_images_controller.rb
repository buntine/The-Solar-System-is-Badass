class TinyMceImagesController < ApplicationController
  layout false

  def new
    @tiny_mce_image = TinyMceImage.new
  end

  def create
    @tiny_mce_image = TinyMceImage.new(params[:tiny_mce_image])

    unless @tiny_mce_image.save
      render :action => "new"
    end
  end

end
