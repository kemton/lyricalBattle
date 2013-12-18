class MessagesController < ApplicationController

  def index
    @messages = Message.all
  end

  #def new
  #  @message = Message.new
  #end

  def create
    @message = Message.new
    @message.content = params[:message][:content]
    @message.user = current_user
    @message.room_number = params[:message][:room_number]
    @channel = params[:message][:room_number]

    if @message.save
      broadcast("/channels/#{@channel}", @message)
      render :json => @message
    else
      redirect_to root_path
    end

  end

  private

    def broadcast(channel, object)
      message = {:channel => channel, :data => {:object => object, :channel => channel, :type => "message"}, :ext => {:auth_token => FAYE_TOKEN}}
      uri = URI.parse("http://localhost:9292/faye")
      Net::HTTP.post_form(uri, :message => message.to_json)
    end

end
