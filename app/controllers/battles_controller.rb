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
		@battle.first_line = params[:battle][:first_line]
		@battle.user = current_user

		if @battle.save
			redirect_to @battle
		else
			redirect_to root_path
		end
	end
end
