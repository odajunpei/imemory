class Members::DestinationsController < ApplicationController


  def create
   @destination = Destination.new(destination_params)
   @destination.member_id = current_member.id
    if @destination.save
      redirect_to destinations_path
    else
      @member = current_member
      render "index"
    end
  end

  def index
    @member = current_member
    @destination = Destination.new
  end

  def edit
    @destination = Destination.find(params[:id])
  end

  def update
    @destination = Destination.find(params[:id])
    if @destination.update(destination_params)
      redirect_to destinations_path
    else
      render :edit
    end
  end

  def destroy
    @destination = Destination.find(params[:id])
    @destination.destroy
    redirect_to destinations_path
  end

  private

  def destination_params
    params.require(:destination).permit(:member_id,:postal_code, :address, :name)
  end


end
