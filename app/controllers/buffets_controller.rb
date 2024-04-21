class BuffetsController < ApplicationController
  def new
    @buffet = Buffet.new
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