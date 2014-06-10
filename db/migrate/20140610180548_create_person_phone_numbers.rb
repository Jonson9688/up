class CreatePersonPhoneNumbers < ActiveRecord::Migration
  def change
    create_table :person_phone_numbers do |t|
      t.integer :person_id
      t.string :phone_number
      t.string :phone_type

      t.timestamps
    end
  end
end
