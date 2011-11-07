class AlbumsController < ApplicationController
  def index
    @albums = File.binread('public/albums.json')

    respond_to do |format|
      format.json { render :json => @albums }
    end
  end
end
