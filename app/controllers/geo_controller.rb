class GeoController < ApplicationController
  
  def index
    results = Geocoding::get(params[:address])
    @longitude = results[0].longitude
    @latitude = results[0].latitude
  end
end