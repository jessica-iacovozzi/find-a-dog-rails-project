class PagesController < ApplicationController
  def home
    @dogs = Dog.all
    markers
  end

  def markers
    @markers = @dogs.map do |dog|
      {
        lat: dog.latitude,
        lng: dog.longitude,
        infoWindow: render_to_string(partial: 'info_window', locals: { dog: })
      }
    end
  end
end
