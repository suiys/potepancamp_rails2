class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.text :introduction
      t.integer :room_charge
      t.string :address
      t.integer :user_id

      t.timestamps
    end
  end
end
