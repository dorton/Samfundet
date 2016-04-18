class SultenLycheOpeningHours < ActiveRecord::Migration
  def change
    create_table :sulten_lyche_opening_hours do |t|
      t.time :open_lyche
      t.time :close_lyche
      t.time :open_kitchen
      t.time :close_kitchen
      t.integer :day_number

      t.timestamps

    end
    add_column :sulten_reservation_types, :needs_kitchen, :boolean
  end
end
