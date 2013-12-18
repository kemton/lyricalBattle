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
    battle = Battle.find(params[:message][:battle])
    @message.battle = battle
    #parent = Message.find(params[:message][:battle])
    #@message.parent = parent
    @channel = battle.id

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
