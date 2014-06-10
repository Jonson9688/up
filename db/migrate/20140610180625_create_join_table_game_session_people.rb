class CreateJoinTableGameSessionPeople < ActiveRecord::Migration
  def change
    create_join_table :people, :game_sessions do |t|
      # t.index [:person_id, :game_session_id]
      # t.index [:game_session_id, :person_id]
    end
  end
end
