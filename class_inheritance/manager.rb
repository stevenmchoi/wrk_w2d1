require_relative 'employee'
require 'byebug'

class Manager < Employee
  attr_reader :employees

  def initialize(name, title, salary, boss)
    super
    @employees = []
  end

  def add_employee(employee)
    self.employees << employee
  end

  def bonus(multiplier)
    employees_sum_salary * multiplier
  end

  protected

  def employees_sum_salary
    # debugger
    employees.reduce(0) do | total, employee |
      total += employee.salary

      if employee.is_a?(Manager)
        total += employee.employees_sum_salary
      end

      total
    end
  end
end
