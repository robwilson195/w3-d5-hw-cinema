require('pry')
require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')

Customer.delete_all
Film.delete_all
Ticket.delete_all

customer1 = Customer.new({'name' => 'Rob Wilson','funds' => '20'})
customer1.save
customer2 = Customer.new({'name' => 'Ray Greenan','funds' => '10'})
customer2.save

film1 = Film.new({'title' => 'Mission Impossible', 'price' => '12'})
film1.save
film2 = Film.new({'title' => 'La La Land', 'price' => '9'})
film2.save

# screening1 = ({'film_id' => film1.id, 'film_title' => film1.title, 'show_time' => '16.30'})
# screening1.save
# screening2 = ({'film_id' => film2.id, 'film_title' => film2.title, 'show_time' => '17.30'})
# screening2.save
# screening3 = ({'film_id' => film1.id, 'film_title' => film1.title, 'show_time' => '18.30'})
# screening3.save
# screening4 = ({'film_id' => film2.id, 'film_title' => film2.title, 'show_time' => '19.30'})
# screening4.save

ticket1 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket1.save
ticket2 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket2.save

binding.pry
nil
