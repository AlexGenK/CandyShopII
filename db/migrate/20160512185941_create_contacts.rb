class CreateContacts < ActiveRecord::Migration
  def change
  	create_table :contacts do |c|
  		c.text :email
  		c.text :message

  		c.timestamps
  	end
  end
end
