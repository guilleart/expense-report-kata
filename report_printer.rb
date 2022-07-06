#!/usr/bin/ruby
require 'readline'
require 'thor'
require_relative 'expense'

class ReportPrinter
  def print_report(*expenses)
    total = 0
    meal_expenses = 0
    puts "Expenses: #{Time.now}"
    for expense in expenses
      if expense.type == :dinner || expense.type == :breakfast
        meal_expenses += expense.amount
      end
      expense_name = ""
      case expense.type
      when :breakfast
          expense_name = "Breakfast"
      when :dinner
          expense_name = "Dinner"
      when :car_rental
          expense_name = "Car Rental"
      end
      meal_over_expenses_marker = expense.type == :dinner && expense.amount > 5000 || expense.type == :breakfast && expense.amount > 1000 ? "X" : " "
      puts "#{expense_name}\t#{expense.amount}\t#{meal_over_expenses_marker}"
      total += expense.amount
    end
    puts "Meal Expenses: #{meal_expenses}"
    puts "Total Expenses: #{total}"
  end
end
