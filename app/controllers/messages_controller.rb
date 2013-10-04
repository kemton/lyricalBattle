class MessagesController < ApplicationController

  def index
    @messages = Message.all
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.create!(params[:message].permit(:content, :sender, :room_number))
    #PrivatePub.publish_to("/messages/new", "alert('#{@message.content}');")
    # redirect to show action: redirect_to message_path(@message)
    #redirect_to messages_path
  end

end