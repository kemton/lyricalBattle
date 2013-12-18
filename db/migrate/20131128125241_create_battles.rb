class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|
      t.belongs_to :message
      t.belongs_to :user

      t.timestamps
    end
  end
end
