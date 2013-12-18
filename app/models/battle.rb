class Battle < ActiveRecord::Base
	belongs_to :user #, :foreign_key => "id"
	validates :user, presence: true
end
