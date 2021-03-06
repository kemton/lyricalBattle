class MessagesController < ApplicationController

  def index
    @messages = Message.all
  end

  def show
    @message = Message.find(params[:id])
  end

  def create
    @message = Message.new(:parent_id => params[:message][:parent_id])
    @message.content = params[:message][:content]
    @message.user = current_user
    @message.battle = Battle.find(params[:message][:battle])

    if @message.save
      broadcast("/channels/#{@channel}", @message)
      @channel = @message.battle.id
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
