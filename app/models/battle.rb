class Battle < ActiveRecord::Base
	#has_one :user
	belongs_to :user #, :foreign_key => "id"
end
