class Message < ActiveRecord::Base
	has_ancestry
	belongs_to :user
	belongs_to :battle
	#validates :content, :user, :battle, presence: true
end
