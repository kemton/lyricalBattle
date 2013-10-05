class RoomsController < ApplicationController
  def index
  end

  def show
  	@messages = Message.where("room_number" => params[:id])
  end
end
