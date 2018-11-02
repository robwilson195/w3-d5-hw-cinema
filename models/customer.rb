require_relative('../db/sql_runner')
require_relative('film.rb')
require_relative('ticket.rb')

class Customer

  attr_reader :id, :funds
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.find_one_by_id(id)
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)[0]
    return Customer.new(result)
  end

  def save
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2)
    RETURNING id"
    values = [@name, @funds]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def delete
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql,values)
  end

  def films
    sql = "SELECT films.* FROM films
    INNER JOIN tickets
    ON films.id = tickets.film_id
    INNER JOIN customers
    ON tickets.customer_id = customers.id
    WHERE customers.id = $1"
    value = [@id]
    result = SqlRunner.run(sql, value)
    return result.map {|film| Film.new(film)}
  end

  def can_afford?(film_title)
    sql = "SELECT * FROM films WHERE title = $1"
    value = [film_title]
    result = SqlRunner.run(sql, value)
    film_object = Film.new(result[0])
    return @funds >= film_object.price.to_i
  end

  def buy_ticket_by_title(film_title)
    if can_afford?(film_title)
      chosen_film = Film.find_one_by_title(film_title)
      new_ticket = Ticket.new({'customer_id' => @id, 'film_id' => chosen_film.id})
      new_ticket.save
      @funds -= chosen_film.price
    else
      return nil
    end
  end

end
