class PhotosController < ApplicationController
  def index
    @photos = Photo.all
    render :index
  end

  def create
    @photo = Photo.create(
      name: params[:name],
      width: params[:width],
      height: params[:height],
    )
    render :show
  end

  def show
    @photo = Photo.find_by(id: params[:id])
    render :show
  end

  def update
    @photo = Photo.find_by(id: params[:id])
    @photo.update(
      name: params[:name] || @photo.name,
      width: params[:width] || @photo.width,
      height: params[:height] || @photo.height,
    )
    render :show
  end

  def destroy
    @photo = Photo.find_by(id: params[:id])
    @photo.destroy
    render json: { message: "Photo destroyed successfully" }
  end
end
