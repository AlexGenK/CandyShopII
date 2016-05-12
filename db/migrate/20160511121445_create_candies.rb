class CreateCandies < ActiveRecord::Migration
  
  def change
  	create_table :candies do |c|
  		c.text :candyname

  		c.timestamps
  	end
  	
  	Candy.create :candyname => 'Foxie'
  	Candy.create :candyname => 'Angela'
  	Candy.create :candyname => 'Tasha'
  	Candy.create :candyname => 'Dolores'
  	Candy.create :candyname => 'Apolonia'
  end

end
