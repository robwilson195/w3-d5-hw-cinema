require_relative('../db/sql_runner')

class Film

  attr_reader :id, :title, :price

  def initialize(options)
    @id = options['id'] if options['id']
    @title = options['title']
    @price = options['price']
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def save
    sql = "INSERT INTO films (title, price) VALUES ($1, $2)
    RETURNING id"
    values = [@title, @price]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id']
  end

end
