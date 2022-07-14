#!/usr/bin/ruby
require 'thor'
require_relative 'expense'

class ReportPrinter
  MEALS = [:dinner, :breakfast]
  OVER_EXPENSES = {
    breakfast: 1000,
    dinner: 5000
  }

  def print_report(*expenses)
    total = 0
    meal_expenses = 0

    puts "Expenses: #{Time.now}"

    expenses.each do |expense|
      meal_expenses += expense.amount if MEALS.include?(expense.type)
      puts "#{expense.name}\t#{expense.amount}\t#{expense_marker(expense)}"
      total += expense.amount
    end

    puts "Meal Expenses: #{meal_expenses}"
    puts "Total Expenses: #{total}"
  end

  private

  def mark_expense?(expense)
    expense.amount > OVER_EXPENSES.fetch(expense.type) { Float::INFINITY }
  end

  def expense_marker(expense)
    mark_expense?(expense) ? "X" : ""
  end
end
