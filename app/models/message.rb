class Message < ActiveRecord::Base
	belongs_to :user
	validates :content, :user, :room_number, presence: true
end
