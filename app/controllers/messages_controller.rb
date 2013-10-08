class MessagesController < ApplicationController

  def index
    @messages = Message.all
  end

  #def new
  #  @message = Message.new
  #end

  def create
    @message = Message.create!(params[:message].permit(:content, :sender, :room_number))
    @channel = params[:message][:room_number]
    PrivatePub.publish_to("/channels/#{@channel}", message: @message)
    #redirect_to messages_path
  end

end
