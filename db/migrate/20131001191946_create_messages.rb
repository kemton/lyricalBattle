class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :user
      t.text :content
      t.belongs_to :battle
      
      t.timestamps
    end
  end
end
