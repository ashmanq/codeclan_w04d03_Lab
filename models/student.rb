require_relative('../db/sql_runner')


class Student

  attr_reader :id
  attr_accessor :first_name, :last_name, :house_id, :age
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @house_id = options['house_id'].to_i
    @age = options['age'].to_i
    # @house_id = option['house_id']
  end

  def full_name()
    return "#{@first_name} #{@last_name}"
  end

  def save()
    sql = "INSERT INTO students
            (
              first_name,
              last_name,
              house_id,
              age
            )
            VALUES
            (
              $1, $2, $3, $4
            )
            RETURNING id"
    values = [@first_name, @last_name, @house_id, @age]
    @id = SqlRunner.run(sql, values).first['id']
  end

  def self.delete_all()
    sql = "DELETE FROM students"
    SqlRunner.run(sql)
  end

  def self.find_all()
    sql = "SELECT * FROM students"
    student_results = SqlRunner.run(sql)
    return nil if student_results.first == nil
    return student_results.map {|student| Student.new(student)}
  end

  def self.find(id)
    sql = "SELECT * FROM students WHERE id = $1"
    values=[id]
    result = SqlRunner.run(sql, values).first
    return nil if result == nil
    return Student.new(result)
  end

  def find_house()
    house = House.find(@house_id)
    return house
  end

end
