class MessagesController < ApplicationController

  def index
    @messages = Message.all
  end

  #def new
  #  @message = Message.new
  #end

  def create
    @message = Message.create!(params[:message].permit(:content, :user, :room_number))
    @channel = params[:message][:room_number]
    broadcast("/channels/#{@channel}", @message)
    render :json => @message
    #PrivatePub.publish_to("/channels/#{@channel}", message: @message)
    #redirect_to messages_path
  end

  private

    def broadcast(channel, object)
      message = {:channel => channel, :data => {:object => object, :channel => channel, :type => "message"}, :ext => {:auth_token => FAYE_TOKEN}}
      uri = URI.parse("http://localhost:9292/faye")
      Net::HTTP.post_form(uri, :message => message.to_json)
    end

end
