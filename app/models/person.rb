class Person < ActiveRecord::Base
  has_many :person_phone_numbers
  has_and_belongs_to_many :game_sessions

  # to do - validate uniqueness of person/phone number
  # to do - add is_valid column to personPhoneNUmber

  def add_phone_number(phone_number, phone_type)
    self.person_phone_numbers << (PersonPhoneNumber.new :phone_number => phone_number, :phone_type => phone_type)
  end


  def create_game_session(sport, location, start_time)
    # check if open game session already exists
    gs = self.has_open_game_session
    if !gs
      self.game_sessions <<  (GameSession.new :sport => sport, :location => location, :start_time => start_time, :request_time => DateTime.now, :owner_id => self.id)
    else
      puts "Open game session (id=#{gs.id}) already exists"
    end
  end

  def has_open_game_session
    # rework logic here, its not right
    # return most recent valid request
    gs = self.game_sessions.order("request_time DESC").first
    gs if gs.is_valid
  end 

  def cancel_open_game_session
    gs = self.has_open_game_session
    if gs
      gs.cancel_game_session
      puts "Cancelled game session (id=#{gs.id})"
    else
      puts "No open game sessions found!"
    end
  end 

end
