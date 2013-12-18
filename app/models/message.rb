class Message < ActiveRecord::Base
	belongs_to :user
	belongs_to :battle
	validates :content, :user, :battle, presence: true
end
