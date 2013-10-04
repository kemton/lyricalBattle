class RoomsController < ApplicationController
  def index
  end

  def show
  	@message = Message.where("room_number" => params[:id])
  end
end
