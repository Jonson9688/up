class PersonPhoneNumber < ActiveRecord::Base
  belongs_to :person

  def find_or_create_person
    @person = self.person
     if !@person
       @person = Person.new
       @person.save
       self.person_id = @person.id
       self.save
     end
     @person
  end 
end
