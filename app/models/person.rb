class Person < ActiveRecord::Base
  has_many :person_phone_numbers
  has_and_belongs_to_many :game_sessions

  def set_name(p_firstname, p_nickname, p_lastname)
    self.firstname = p_firstname
    self.nickname = p_nickname
    self.lastname = p_lastname
    self.save!
  end


  def add_phone_number(phone_number, phone_type)
  # to do - validate uniqueness of person/phone number
  # to do - add is_valid column to personPhoneNUmber
    self.person_phone_numbers << (PersonPhoneNumber.new :phone_number => phone_number, :phone_type => phone_type)
  end


  def create_game_session(sport, location, start_time)
    # check if open game session already exists
    gs = self.has_open_game_session
    if !gs
      gs = GameSession.new :sport => sport, :location => location, :start_time => start_time, :request_time => DateTime.now, :owner_id => self.id
      self.game_sessions << (gs)
      gs 
    else
      puts "Open game session (id=#{gs.id}) already exists"
      nil 
    end
  end

  def has_open_game_session
    # rework logic here, its not right
    # return most recent valid request
    gs = self.game_sessions.order("request_time DESC").first
    if gs
      gs if gs.is_valid
    end
  end 

  def cancel_open_game_session
    gs = self.has_open_game_session
    if gs
      gs.cancel_game_session
      puts "Cancelled game session (id=#{gs.id})"
      gs
    else
      puts "No open game sessions found!"
      nil
    end
  end 

end
