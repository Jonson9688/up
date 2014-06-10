class GameSession < ActiveRecord::Base
  has_and_belongs_to_many :people
  belongs_to :person, :foreign_key => :person_id

  # todo - validate that an owner exists

  def register_person(person_id)
    # todo - validate that person isn't already in table
    if is_valid
      self.people << Person.find(person_id)
      puts "Person_id #{person_id} is registered"
    else
      puts "Game session is invalid, not registering person"
    end
  end

  def is_valid
    # todo - change expiration time to be a setting in db or config
    !is_cancelled && (DateTime.now < request_time + 3.hours) 
  end

  def cancel_game_session
    self.is_cancelled = true
    self.save!
  end
end
