class TwilioController < ApplicationController
  def parse_message 
#    if params[:textaction] == "register_person"
#      @person = Person.new( :firstname => params[:firstname], :lastname => params[:lastname], :nickname => params[:nickname])
#      @person.save
#    elsif params[:textaction] == "create_game_session"
      # this shoudl be better way to find by association
#      @person_phone = PersonPhoneNumber.find_by_phone_number( params[:phone_number] )
#      @person_phone.person.create_game_session( params[:sport], params[:location], params[:time])

 #   elsif params[:textaction] == "existing_game_sessions"
 #   elsif params[:textaction] == "join_game_session"
 #   elsif params[:textaction] == "cancel_game_session"
#      @person_phone = PersonPhoneNumber.find_by_phone_number( params[:phone_number] )
#      @person_phone.person.cancel_open_game_session

#    elsif params[:textaction] == "display_game_session_roster"
#    end 
#    @people = Person.all

######
    if params[:textmessage] != nil && params[:phone_number] != nil

      # if phone doesnt exist, then create it with empty person_id
      @phone = PersonPhoneNumber.where( :phone_number => params[:phone_number]).first_or_create

      # remove the first and replace with better logic
      @person = @phone.find_or_create_person 
      commands = params[:textmessage].split(' ') 
      if commands[0] == "REGISTER"
        @person.set_name(commands[1], commands[2], commands[3]) 
        @response = "Person first nick and last name set. ID: #{@person.id}. First: #{@person.firstname}. Nick: #{@person.nickname}. Last: #{@person.lastname}."
      elsif commands[0] == "MAKEGAME"
        @gs = @person.create_game_session(commands[1], commands[2], commands[3])
        # make logic here better
        if @gs
          @response = "Game created. Game session id = #{@gs.id}"
        else
          # should fix logic here
          @gs = @person.has_open_game_session
          @response = "Open game session (id=#{@gs.id}) already exists!"
        end
      elsif commands[0] == "CANCELGAME"
        # rename @result variable
        @result = @person.cancel_open_game_session
        if @result
          @response = "Cancelled game session (id=#{@result.id})"
        else
          @response = "No open game sessions to cancel!"
        end
      elsif commands[0] == "JOINGAME"
        @gs = GameSession.find(commands[1] )
        if @gs
          @gs.register_person(@person.id)
          #to do - only allow register if person isnt on already - add logic
          @response = "Registered in game"
        else
          @response = "Game session (id=#{@gs.id}) does not exist"
        end
      elsif commands[0] == "VIEWROSTER"
        @gs = GameSession.find(commands[1] )
        if @gs
          @people = @gs.return_roster
          @response = "ROSTER:"
          @people.each do |p|
            @response += "#{p.firstname} \"#{p.nickname}\" #{p.lastname}, "
          end 
        end
      end
    end

  end


end
