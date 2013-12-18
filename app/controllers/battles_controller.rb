class BattlesController < ApplicationController
	def index
		#time_range = (Time.now - 1.day)..Time.now
		#@battles = Message.where("created_at" => time_range)
		@battles = Battle.all.joins(:user)
	end

	def show
		if Battle.exists?("id" => params[:id])
			@battle = Battle.where("id" => params[:id]).first
			@messages = Message.where("battle_id" => params[:id])
			@user = User.where("id" => @battle.user_id).first
		else
			redirect_to root_path
		end
	end

	def create
		@battle = Battle.new
		@battle.user = current_user
		@battle.save

		message = Message.new
		message.content = params[:battle][:message]
		message.user = current_user
		message.battle = @battle
		message.save

		@battle.message = message

		if @battle.save
			redirect_to @battle
		else
			redirect_to root_path
		end
	end
end
