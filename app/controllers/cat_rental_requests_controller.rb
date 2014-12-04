class CatRentalRequestsController < ApplicationController
  def new
    @cat_rental_request = CatRentalRequest.new
    @cats = Cat.all
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(request_params)
    if @cat_rental_request.save
      redirect_to cat_url(request_params[:cat_id])
    else
      @cats = Cat.all
      render :new
    end
  end

  private

  def request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
