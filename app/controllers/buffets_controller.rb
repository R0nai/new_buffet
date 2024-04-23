class BuffetsController < ApplicationController
  before_action :authenticate_owner!, only: [:new, :edit]
  
  def index
    @buffets = Buffet.all
    @is_owner_without_buffet = current_owner && !current_owner.buffet
  end

  def show
    @buffet = Buffet.find(params[:id])
    @is_owner_valid = current_owner && @buffet.owner_id == current_owner.id
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