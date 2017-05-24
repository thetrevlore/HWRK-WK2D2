class CatsController < ApplicationController

  def index
    @cats = Cat.all
    render :index
  end

  def show #this is after a specific cat is selected
    @cat = Cat.find(params[:id])
    render :show
  end

  def new  #new will return the big ugly hash with controller in it, so it needs cat_params
    @cat = Cat.new
  end

  def create
    cat = Cat.new(cat_params)

    if cat.save
      redirect_to cat_url(cat)
    else
      render json: cat.errors.full_messages,
        status: :unprocessable_entity
    end
  end

  def edit
    @cat = Cat.find(params[:id])
  end

  def update
    cat = Cat.find(params[:id]) #id is in url

    if cat.update(cat_params)
      redirect_to cat_url(cat)
    else
      render json: cat.errors.full_messages,
        status: :unprocessable_entity
    end
  end


  private

  def cat_params
    params.require(:cat).permit(:name, :birth_date, :color, :sex, :description)
  end
end
