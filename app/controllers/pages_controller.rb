class PagesController < ApplicationController
  def home
    @dogs = Dog.paginate(page: params[:page], per_page: 20)
  end
end
