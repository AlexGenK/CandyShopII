class CreateClients < ActiveRecord::Migration

  def change
  	create_table :clients do |c|
  		c.text :name
  		c.text :phone
  		c.text :date
  		c.text :candy
  		c.text :color

  		c.timestamps
  	end
  end
  
end
