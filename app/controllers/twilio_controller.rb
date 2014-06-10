class TwilioController < ApplicationController
  def parse_message 
    if params[:textaction] == "register_person"
      @person = Person.new( :firstname => params[:firstname], :lastname => params[:lastname], :nickname => params[:nickname])
      @person.save
    elsif params[:textaction] == "create_game_session"
      # this shoudl be better way to find by association
      @person_phone = PersonPhoneNumber.find_by_phone_number( params[:phone_number] )
      @person_phone.person.create_game_session( params[:sport], params[:location], params[:time])

    elsif params[:textaction] == "existing_game_sessions"
    elsif params[:textaction] == "join_game_session"
    elsif params[:textaction] == "cancel_game_session"
      @person_phone = PersonPhoneNumber.find_by_phone_number( params[:phone_number] )
      @person_phone.person.cancel_open_game_session

    elsif params[:textaction] == "display_game_session_roster"
    end 
    @people = Person.all
  end


end
