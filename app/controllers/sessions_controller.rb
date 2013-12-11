class SessionsController < ApplicationController
	def create
		#user = User.from_omniauth(env["omniauth.auth"])

		#debug
		user = User.new
		user.provider = "facebook"
		user.uid = "123456"
		user.name = "Niko Kiuru"
		user.oauth_token = "ABCDE"
		user.oauth_expires_at = Time.at(1321747205)
		user.save!
		
		session[:user_id] = user.id
		redirect_to root_url
	end

	def omniauth_failure
		redirect_to root_url
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url
	end
end
