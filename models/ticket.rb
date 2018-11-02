require_relative('../db/sql_runner')

class Ticket

  attr_reader :id, :customer_id, :film_id

  def initialize(options)
    @id = options['id'] if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def save
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2)
    RETURNING id"
    values = [@customer_id, @film_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id']
  end

end
