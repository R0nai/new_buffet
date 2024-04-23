class BuffetsController < ApplicationController
  
  def index
    @buffets = Buffet.all
  end

  def show
    @buffet = Buffet.find(params[:id])
  end

  def new
    @buffet = Buffet.new
  end

  def edit
    @buffet = Buffet.find(params[:id])
  end

  def create
    buffet_params = params.require(:buffet).permit(
      :brand,
      :corporate_name,
      :registration_number,
      :phone_number,
      :email,
      :address,
      :district,
      :state,
      :city,
      :zip_code,
      :description
    )
    @buffet = Buffet.new(buffet_params)
    @buffet.owner_id = current_owner.id
    @buffet.save!
    redirect_to root_path
  end

end