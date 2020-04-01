require_relative('../db/sql_runner')


class House
  attr_reader :id
  attr_accessor :name, :logo
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @logo = options['logo']
  end

  def save()
    sql = "INSERT INTO houses
            (
              name,
              logo
            )
            VALUES
            (
              $1, $2
            )
            RETURNING id"
    values = [@name, @logo]
    @id = SqlRunner.run(sql, values).first['id']
  end

  def delete()
    sql = "Delete FROM houses WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM houses"
    SqlRunner.run(sql)
  end

  def self.find_all()
    sql = "SELECT * FROM houses"
    houses_results = SqlRunner.run(sql)
    return nil if houses_results.first == nil
    return houses_results.map {|house| House.new(house)}
  end

  def self.find(id)
    sql = "SELECT * FROM houses WHERE id = $1"
    values=[id]
    result = SqlRunner.run(sql, values).first
    return nil if result == nil
    return House.new(result)
  end

end
