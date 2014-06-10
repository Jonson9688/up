class CreateGameSessions < ActiveRecord::Migration
  def change
    create_table :game_sessions do |t|
      t.integer :owner_id
      t.timestamp :start_time
      t.string :location
      t.string :sport
      t.timestamp :request_time
      t.string :is_cancelled

      t.timestamps
    end
  end
end
