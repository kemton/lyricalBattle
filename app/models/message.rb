class Message < ActiveRecord::Base
	belongs_to :user
	belongs_to :battle
	belongs_to :parent, class_name: "Message"
	validates :content, :user, :battle, presence: true
end
