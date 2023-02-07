class PagesController < ApplicationController

  def home
    @dogs = Dog.paginate(page: params[:page], per_page: 20)
    # markers
  end

  def markers
    @markers = @dogs.geocoded.map do |dog|
      {
        lat: dog.latitude,
        lng: dog.longitude,
        infoWindow: render_to_string(partial: 'info_window', locals: { dog: }),
        image_url: helpers.asset_url('pin.png')
      }
    end
  end
end
