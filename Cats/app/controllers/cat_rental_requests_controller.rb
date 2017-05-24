class CatRentalRequestsController < ApplicationController
  def new
    @cats = Cat.all
    
  end
end
