class PagesController < ApplicationController
  def home
    @dogs = Dog.all

    @markers = @dogs.map do |dog|
      {
        lat: dog.latitude,
        lng: dog.longitude
        # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
        # Uncomment the above line if you want each of your markers to display a info window when clicked
        # (you will also need to create the partial "/flats/map_box")
      }
    end
  end
end
