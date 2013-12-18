class Battle < ActiveRecord::Base
	belongs_to :user #, :foreign_key => "id"
	belongs_to :message
	validates :user, presence: true
end
