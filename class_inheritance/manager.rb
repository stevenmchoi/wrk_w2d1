require_relative 'employee'

class Manager < Employee
  attr_reader :employees

  def initialize(name, title, salary, boss)
    super
    @employees = []
  end

  def add_employee(employee)
    self.employees << employee
  end
end
