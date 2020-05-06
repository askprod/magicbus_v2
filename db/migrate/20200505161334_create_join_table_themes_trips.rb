class CreateJoinTableThemesTrips < ActiveRecord::Migration[5.2]
  def change
    create_join_table :themes, :trips do |t|
      t.index [:theme_id, :trip_id]
      t.index [:trip_id, :theme_id]
    end
  end
end
