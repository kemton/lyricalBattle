class Message < ActiveRecord::Base
	validates :content, :user, :room_number, presence: true
end
